import 'package:bookshelf_builder/features/planner/domain/models/cut_sheet.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cut_layout_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const builder = CutLayoutBuilder();

  List<CutSheet> layoutFor(Inputs i) {
    final p = planFor(i);
    return builder.build(parts: p.parts, depthPanel: p.depthPanel);
  }

  final variants = <String, Inputs>{
    'default': const Inputs(),
    'home layout': Inputs.home,
    'wide columns': const Inputs(left: 40, right: 40),
    'tall bars': const Inputs(top: 20, bottom: 20),
    'off the floor': const Inputs(onFloor: false),
    'shallow': const Inputs(depth: 8),
    'deep': const Inputs(depth: 15),
    'big window': const Inputs(windowW: 60, windowH: 60),
    'edge band': const Inputs(edgeStiffener: true),
  };

  group('every variant', () {
    for (final e in variants.entries) {
      test('${e.key}: every piece is placed exactly once', () {
        final p = planFor(e.value);
        final sheets = builder.build(parts: p.parts, depthPanel: p.depthPanel);
        final placed = [
          for (final s in sheets)
            for (final piece in s.pieces) piece.id,
        ];
        final expected = [
          for (final part in p.parts)
            if (part.material != PartMaterial.edgeBand &&
                part.length <= Limits.sheetL)
              ...part.ids,
        ];
        expect(placed.toSet().length, placed.length);
        // A back bigger than a sheet is cut in pieces named J1a, J1b.
        final whole = {
          for (final id in placed) id.replaceAll(RegExp('[a-z]\$'), ''),
        };
        expect(whole, expected.toSet());
      });

      test('${e.key}: nothing overlaps and everything is on the sheet', () {
        for (final s in layoutFor(e.value)) {
          for (final a in s.pieces) {
            expect(a.x, greaterThanOrEqualTo(0));
            expect(a.y, greaterThanOrEqualTo(0));
            expect(a.x + a.length, lessThanOrEqualTo(Limits.sheetL + 1e-9));
            expect(a.y + a.width, lessThanOrEqualTo(Limits.sheetW + 1e-9));
            for (final b in s.pieces) {
              if (identical(a, b)) continue;
              // Two pieces must be at least a saw kerf apart on one axis.
              final apartX =
                  a.x + a.length + Limits.kerf <= b.x + 1e-9 ||
                  b.x + b.length + Limits.kerf <= a.x + 1e-9;
              final apartY =
                  a.y + a.width + Limits.kerf <= b.y + 1e-9 ||
                  b.y + b.width + Limits.kerf <= a.y + 1e-9;
              expect(
                apartX || apartY,
                isTrue,
                reason: '${a.id} touches ${b.id} on sheet ${s.number}',
              );
            }
          }
        }
      });

      test('${e.key}: the sheet counts match the estimate', () {
        final p = planFor(e.value);
        final sheets = builder.build(parts: p.parts, depthPanel: p.depthPanel);
        expect(
          sheets.where((s) => s.material == PartMaterial.ply34).length,
          p.sheets.sheets34,
        );
        expect(
          sheets.where((s) => s.material == PartMaterial.ply14).length,
          p.sheets.backSheets,
        );
      });
    }
  });

  group('default plan', () {
    final sheets = layoutFor(const Inputs());
    final plywood = sheets.where((s) => s.material == PartMaterial.ply34);

    test('needs three 3/4 inch sheets and one back sheet', () {
      expect(plywood.length, 3);
      expect(sheets.length, 4);
    });

    test('sheets are numbered from 1 within their material', () {
      expect([for (final s in plywood) s.number], [1, 2, 3]);
      expect(sheets.last.number, 1);
    });

    test('wide strips are one panel depth wide with a kerf between', () {
      final s = plywood.first;
      final dp = planFor().depthPanel;
      expect(s.stripTops.length, 4);
      for (final t in s.stripTops.take(4)) {
        expect(s.stripWidth(t), closeTo(dp, 1e-9));
      }
      expect(s.stripTops[1], closeTo(dp + Limits.kerf, 1e-9));
    });

    test('pieces in a strip are a kerf apart', () {
      final s = plywood.first;
      final strip = s.strip(s.stripTops.first);
      expect(strip.length, greaterThan(1));
      expect(
        strip[1].x,
        closeTo(strip[0].x + strip[0].length + Limits.kerf, 1e-9),
      );
    });

    test('the long pieces go first', () {
      final first = plywood.first.strip(0).first;
      expect(first.length, 76);
    });

    test('narrow pieces are ripped from the leftover width', () {
      final narrow = [
        for (final s in plywood)
          for (final p in s.pieces)
            if (p.width < 5) p,
      ];
      expect(narrow.map((p) => p.name), containsAll(['Toe kick']));
      for (final p in narrow) {
        expect(p.width, 3.5);
      }
    });

    test('back panels are cut 1/16 inch under size on every edge', () {
      final back = sheets.last.pieces.firstWhere(
        (p) => p.name == 'Back panel, left column',
      );
      expect(back.length, 76 - 0.125);
      expect(back.width, 14 - 0.125);
    });

    test('the back pieces share rows to fit on one sheet', () {
      expect(sheets.last.pieces.length, 4);
      expect(sheets.last.stripTops.toSet().length, 3);
    });
  });

  group('edge cases', () {
    test('a part longer than a sheet is left out', () {
      final sheets = builder.build(
        parts: [
          const Part('Long', 1, 100, 11, PartMaterial.ply34).withLabel('A'),
          const Part('Short', 1, 20, 11, PartMaterial.ply34).withLabel('B'),
        ],
        depthPanel: 11,
      );
      final ids = [
        for (final s in sheets)
          for (final p in s.pieces) p.id,
      ];
      expect(ids, ['B1']);
    });

    test('the edge band is not cut from a sheet', () {
      final sheets = builder.build(
        parts: [
          const Part('Band', 1, 240, 0, PartMaterial.edgeBand).withLabel('A'),
        ],
        depthPanel: 11,
      );
      expect(sheets, isEmpty);
    });

    test('no parts means no sheets', () {
      expect(builder.build(parts: const [], depthPanel: 11), isEmpty);
    });

    test('an unlabelled part still gets a placeholder id', () {
      final sheets = builder.build(
        parts: [const Part('Shelf', 2, 20, 11, PartMaterial.ply34)],
        depthPanel: 11,
      );
      expect(sheets.single.pieces.map((p) => p.id), ['Shelf 1', 'Shelf 2']);
    });

    test('narrow pieces that do not fit spill onto a new sheet', () {
      final sheets = builder.build(
        parts: [
          for (var k = 0; k < 4; k++)
            Part('Wide $k', 1, 90, 11, PartMaterial.ply34).withLabel('W$k'),
          for (var k = 0; k < 3; k++)
            const Part(
              'Toe kick',
              1,
              90,
              3.5,
              PartMaterial.ply34,
            ).withLabel('T$k', firstNumber: k + 1),
        ],
        depthPanel: 11,
      );
      expect(sheets.length, 2);
    });
  });

  group('backs bigger than a sheet', () {
    final p = planFor(const Inputs(left: 57));
    final sheets = builder.build(parts: p.parts, depthPanel: p.depthPanel);
    final backs = [
      for (final s in sheets.where((s) => s.material == PartMaterial.ply14))
        ...s.pieces,
    ];
    final left = p.parts.firstWhere((x) => x.name == 'Back panel, left column');

    test('are cut in equal named pieces', () {
      final id = left.ids.single;
      final pieces = backs.where((b) => b.id.startsWith(id)).toList();
      expect(pieces.map((b) => b.id), ['${id}a', '${id}b']);
      expect(pieces.first.width, pieces.last.width);
    });

    test('the pieces add up to the trimmed back', () {
      final id = left.ids.single;
      final pieces = backs.where((b) => b.id.startsWith(id)).toList();
      final total = pieces.fold<double>(0, (sum, b) => sum + b.width);
      expect(total, closeTo(57 - 0.125, 1e-9));
      for (final b in pieces) {
        expect(b.width, lessThanOrEqualTo(Limits.sheetW));
        expect(b.length, closeTo(p.ringH - 0.125, 1e-9));
      }
    });

    test('a back longer than a sheet is split along its length', () {
      final long = builder.build(
        parts: [
          const Part('Back', 1, 120, 20, PartMaterial.ply14).withLabel('J'),
        ],
        depthPanel: 11,
      );
      final pieces = long.expand((s) => s.pieces).toList();
      expect(pieces.map((b) => b.id), ['J1a', 'J1b']);
      for (final b in pieces) {
        expect(b.length, lessThanOrEqualTo(Limits.sheetL));
      }
    });
  });
}
