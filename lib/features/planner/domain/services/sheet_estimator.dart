import 'dart:math';

import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sheet_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/parts_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/strip_packer.dart';

/// Estimates how many plywood sheets the cut list needs.
class SheetEstimator {
  /// Creates an estimator.
  const SheetEstimator({this.packer = const StripPacker()});

  /// Strip packing strategy.
  final StripPacker packer;

  /// Estimates 3/4" and 1/4" sheets for [parts].
  ///
  /// 3/4" parts are ripped into strips of panel depth, packed first-fit
  /// decreasing, and grouped into sheets. Parts longer than a sheet are left
  /// out (the issue checker warns about them). The toe kick goes into leftover
  /// sheet width when it fits, otherwise it costs one more strip. The 1/4"
  /// back is estimated from total area with an 85 percent yield.
  SheetPlan estimate({
    required List<Part> parts,
    required Dimensions dims,
    required Inputs inputs,
  }) {
    final lengths = <double>[];
    var backArea = 0.0;
    for (final p in parts) {
      if (p.material == PartMaterial.ply34 &&
          p.name != PartsBuilder.toeKickName) {
        if (p.length <= Limits.sheetL) {
          for (var q = 0; q < p.qty; q++) {
            lengths.add(p.length);
          }
        }
      } else if (p.material == PartMaterial.ply14) {
        backArea += p.length * p.width * p.qty;
      }
    }

    final perSheet =
        ((Limits.sheetW + Limits.kerf) / (dims.depthPanel + Limits.kerf))
            .floor()
            .clamp(1, 1000);
    var needed = packer.pack(lengths);
    if (inputs.onFloor && dims.ringW <= Limits.sheetL && needed > 0) {
      final sheets = max(1, (needed / perSheet).ceil());
      final inLast = needed - (sheets - 1) * perSheet;
      final leftover = Limits.sheetW - inLast * (dims.depthPanel + Limits.kerf);
      final fits = inLast < perSheet && leftover >= inputs.toeKick;
      if (!fits) needed += 1;
    }
    final sheets34 = needed == 0 ? 0 : (needed / perSheet).ceil();
    final backSheets =
        (backArea / (Limits.sheetW * Limits.sheetL * Limits.backYield)).ceil();
    return SheetPlan(
      stripsPerSheet: perSheet,
      neededStrips: needed,
      sheets34: sheets34,
      backArea: backArea,
      backSheets: backSheets,
    );
  }
}
