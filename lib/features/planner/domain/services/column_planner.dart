import 'dart:math';

import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/services/divider_calculator.dart';

/// Plans the fixed shelves and dividers of a side column.
class ColumnPlanner {
  /// Creates a planner.
  const ColumnPlanner({this.dividers = const DividerCalculator()});

  /// Divider math.
  final DividerCalculator dividers;

  /// Plans a column of outer width [colW].
  ///
  /// Shelf count is `max(0, ceil((sideH - target) / (target + t)))`. Dividers
  /// are added only when the clear width exceeds the active span limit.
  ColumnPlan plan(double colW, Inputs i, Dimensions dims) {
    const t = Limits.t;
    final clearW = colW - 2 * t;
    final n = max(
      0,
      ((dims.sideH - i.targetClearH) / (i.targetClearH + t)).ceil(),
    );
    final clearH = (dims.sideH - n * t) / (n + 1);
    final d = clearW > dims.spanLimit
        ? dividers.count(clearW, dims.spanLimit)
        : 0;
    return ColumnPlan(
      colW: colW,
      clearW: clearW,
      shelves: n,
      clearH: clearH,
      dividers: d,
      bayW: dividers.bayWidth(clearW, d),
    );
  }
}
