import 'package:bookshelf_builder/features/planner/domain/models/cut_sheet.dart';
import 'package:bookshelf_builder/features/planner/domain/models/layout_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/services/parts_builder.dart';

/// Lays every piece of the cut list out on 4x8 sheets, to scale.
///
/// 3/4" pieces of panel depth go into strips packed first-fit decreasing (the
/// same rule the sheet estimate uses). Narrow pieces (toe kick, cleats) are
/// ripped from the width left over. The 1/4" backs are cut 1/16" under size on
/// every edge, as the guide says, and packed into rows.
class CutLayoutBuilder {
  /// Creates a builder.
  const CutLayoutBuilder();

  /// Each edge of a 1/4" back is cut this much under size, so the back never
  /// overhangs the frame.
  static const double backTrimPerEdge = 1 / 16;

  /// Returns the 3/4" sheets first, then the 1/4" sheets. A 3/4" part longer
  /// than 96 in is left out (the issue checker warns about it); a 1/4" back
  /// bigger than a sheet is cut in equal pieces.
  List<CutSheet> build({
    required List<Part> parts,
    required double depthPanel,
  }) => [..._plywood34(parts, depthPanel), ..._backs(parts)];

  /// The id of piece [k] of [p], or a readable placeholder when the cut list
  /// has not been labelled.
  String _id(Part p, int k) => p.ids.isEmpty ? '${p.name} ${k + 1}' : p.ids[k];

  List<_Item> _items(List<Part> parts, PartMaterial material) {
    final items = <_Item>[];
    for (final p in parts) {
      if (p.material != material) continue;
      if (p.length > Limits.sheetL + 1e-9) continue;
      for (var k = 0; k < p.qty; k++) {
        items.add(_Item(_id(p, k), p.name, p.length, p.width, items.length));
      }
    }
    return items;
  }

  /// The 1/4" backs, each edge cut [backTrimPerEdge] under size. A back that is
  /// bigger than a sheet in either direction is cut in equal pieces named
  /// `J1a`, `J1b` and so on, to be joined behind a divider.
  List<_Item> _backItems(List<Part> parts) {
    final items = <_Item>[];
    for (final p in parts) {
      if (p.material != PartMaterial.ply14) continue;
      final length = p.length - 2 * backTrimPerEdge;
      final width = p.width - 2 * backTrimPerEdge;
      final across = (length / Limits.sheetL - 1e-9).ceil().clamp(1, 26);
      final down = (width / Limits.sheetW - 1e-9).ceil().clamp(1, 26);
      for (var k = 0; k < p.qty; k++) {
        if (across == 1 && down == 1) {
          items.add(_Item(_id(p, k), p.name, length, width, items.length));
          continue;
        }
        for (var j = 0; j < across * down; j++) {
          items.add(
            _Item(
              '${_id(p, k)}${String.fromCharCode(97 + j)}',
              p.name,
              length / across,
              width / down,
              items.length,
            ),
          );
        }
      }
    }
    return items;
  }

  List<CutSheet> _plywood34(List<Part> parts, double depthPanel) {
    final all = _items(parts, PartMaterial.ply34);
    final wide = [
      for (final i in all)
        if (!_narrow(i.name)) i,
    ];
    final narrow = [
      for (final i in all)
        if (_narrow(i.name)) i,
    ];

    // Wide strips: first-fit decreasing, one kerf after every piece.
    wide.sort(_byLengthDesc);
    final strips = <_Row>[];
    for (final item in wide) {
      final row = _fit(strips, item);
      if (row == null) {
        strips.add(_Row(depthPanel)..add(item));
      } else {
        row.add(item);
      }
    }
    final perSheet =
        ((Limits.sheetW + Limits.kerf) / (depthPanel + Limits.kerf))
            .floor()
            .clamp(1, 1000);

    // Narrow rows: widest first, several short pieces can share a row.
    narrow.sort((a, b) {
      final w = b.width.compareTo(a.width);
      return w != 0 ? w : _byLengthDesc(a, b);
    });
    final rows = <_Row>[];
    for (final item in narrow) {
      final row = _fit(rows, item);
      if (row == null) {
        rows.add(_Row(item.width)..add(item));
      } else {
        row.add(item);
      }
    }

    final sheets = <_Sheet>[];
    for (var k = 0; k < strips.length; k++) {
      if (k % perSheet == 0) sheets.add(_Sheet());
      sheets.last.place(strips[k]);
    }
    for (final row in rows) {
      if (sheets.isEmpty || !sheets.last.fits(row)) sheets.add(_Sheet());
      sheets.last.place(row);
    }
    return _finish(sheets, PartMaterial.ply34);
  }

  List<CutSheet> _backs(List<Part> parts) {
    final items = _backItems(parts)
      ..sort((a, b) {
        final w = b.width.compareTo(a.width);
        return w != 0 ? w : _byLengthDesc(a, b);
      });
    final rows = <_Row>[];
    for (final item in items) {
      final row = _fit(rows, item);
      if (row == null) {
        rows.add(_Row(item.width)..add(item));
      } else {
        row.add(item);
      }
    }
    final sheets = <_Sheet>[];
    for (final row in rows) {
      if (sheets.isEmpty || !sheets.last.fits(row)) sheets.add(_Sheet());
      sheets.last.place(row);
    }
    return _finish(sheets, PartMaterial.ply14);
  }

  static bool _narrow(String name) => PartsBuilder.isNarrowStrip(name);

  static int _byLengthDesc(_Item a, _Item b) {
    final c = b.length.compareTo(a.length);
    return c != 0 ? c : a.order.compareTo(b.order);
  }

  /// The first row that has room for [item], or null.
  _Row? _fit(List<_Row> rows, _Item item) {
    for (final row in rows) {
      if (item.width <= row.width + 1e-9 && row.hasRoom(item)) return row;
    }
    return null;
  }

  List<CutSheet> _finish(List<_Sheet> sheets, PartMaterial material) => [
    for (var k = 0; k < sheets.length; k++)
      CutSheet(material: material, number: k + 1, pieces: sheets[k].pieces),
  ];
}

class _Item {
  const _Item(this.id, this.name, this.length, this.width, this.order);

  final String id;
  final String name;
  final double length;
  final double width;
  final int order;
}

/// A ripped strip or row: pieces side by side along the sheet length.
class _Row {
  _Row(this.width);

  final double width;
  final List<_Item> items = [];
  double used = 0;

  bool hasRoom(_Item i) =>
      used + i.length + Limits.kerf <= Limits.sheetL + Limits.kerf + 1e-9;

  void add(_Item i) {
    items.add(i);
    used += i.length + Limits.kerf;
  }
}

/// A sheet being filled from the top edge down.
class _Sheet {
  final List<LayoutPiece> pieces = [];
  double top = 0;

  bool fits(_Row row) => top + row.width <= Limits.sheetW + 1e-9;

  void place(_Row row) {
    var x = 0.0;
    for (final item in row.items) {
      pieces.add(
        LayoutPiece(
          id: item.id,
          name: item.name,
          x: x,
          y: top,
          length: item.length,
          width: item.width,
        ),
      );
      x += item.length + Limits.kerf;
    }
    top += row.width + Limits.kerf;
  }
}
