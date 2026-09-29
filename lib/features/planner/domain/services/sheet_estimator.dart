import 'dart:math';

import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sheet_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cut_layout_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/parts_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/strip_packer.dart';

/// Estimates how many plywood sheets the cut list needs.
class SheetEstimator {
  /// Creates an estimator.
  const SheetEstimator({
    this.packer = const StripPacker(),
    this.layout = const CutLayoutBuilder(),
  });

  /// Strip packing strategy.
  final StripPacker packer;

  /// Lays the pieces out on sheets. The sheet counts are the number of sheets
  /// in that layout, the same one the guide draws.
  final CutLayoutBuilder layout;

  /// Estimates 3/4" and 1/4" sheets for [parts].
  ///
  /// 3/4" parts are ripped into strips of panel depth, packed first-fit
  /// decreasing, and grouped into sheets. Parts longer than a sheet are left
  /// out (the issue checker warns about them). Narrow strips (toe kick and
  /// anchor cleats) go into leftover sheet width when they all fit, otherwise
  /// they cost extra strips. The 1/4" backs are counted from the cutting
  /// layout, which packs them into rows on the sheet.
  SheetPlan estimate({
    required List<Part> parts,
    required Dimensions dims,
    required Inputs inputs,
  }) {
    final lengths = <double>[];
    var narrowWidth = 0.0;
    var backArea = 0.0;
    for (final p in parts) {
      if (p.material == PartMaterial.ply34) {
        if (p.length > Limits.sheetL) continue;
        if (PartsBuilder.isNarrowStrip(p.name)) {
          narrowWidth += (p.width + Limits.kerf) * p.qty;
        } else {
          for (var q = 0; q < p.qty; q++) {
            lengths.add(p.length);
          }
        }
      } else if (p.material == PartMaterial.ply14) {
        backArea += p.length * p.width * p.qty;
      }
    }

    final stripWidth = dims.depthPanel + Limits.kerf;
    final perSheet = ((Limits.sheetW + Limits.kerf) / stripWidth).floor().clamp(
      1,
      1000,
    );
    var needed = packer.pack(lengths);
    if (narrowWidth > 0 && needed > 0) {
      final sheets = max(1, (needed / perSheet).ceil());
      final inLast = needed - (sheets - 1) * perSheet;
      final leftover = Limits.sheetW - inLast * stripWidth;
      final fits = inLast < perSheet && leftover >= narrowWidth;
      if (!fits) needed += (narrowWidth / stripWidth).ceil();
    }
    final placed = layout.build(parts: parts, depthPanel: dims.depthPanel);
    final layout34 = placed.where((s) => s.material == PartMaterial.ply34);
    final layoutBacks = placed.where((s) => s.material == PartMaterial.ply14);
    // The layout is a real arrangement of every piece, so its sheet count is
    // both enough and the one the guide draws.
    final sheets34 = layout34.length;
    final backSheets = layoutBacks.length;
    return SheetPlan(
      stripsPerSheet: perSheet,
      neededStrips: needed,
      sheets34: sheets34,
      backArea: backArea,
      backSheets: backSheets,
    );
  }
}
