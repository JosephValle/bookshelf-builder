import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';

/// Where the four French cleat pieces sit on the unit: two rows, each running
/// across both columns.
///
/// A row is centered on a shelf when it can be, so the screws that hold the
/// unit piece bite the shelf edge behind the 1/4" back.
class CleatLayout {
  /// Creates a layout.
  const CleatLayout();

  /// Number of rows (top and middle).
  static const int rows = 2;

  /// Height from the bottom of the unit to the middle of the left column's
  /// shelf number [k] (one based).
  double shelfCenter(Plan plan, int k) {
    final c = plan.leftCol;
    return plan.dimensions.kick +
        Limits.t +
        k * c.clearH +
        (k - 1) * Limits.t +
        Limits.t / 2;
  }

  /// The number (one based) of the left column shelf that row [row] is
  /// centered on, or null when the row sits flush with the top or bottom.
  int? shelfFor(Plan plan, int row) {
    final n = plan.leftCol.shelves;
    if (row == 0) return n >= 1 ? n : null;
    if (n < 2) return null;
    var best = 1;
    for (var k = 1; k < n; k++) {
      final d = (shelfCenter(plan, k) - plan.ringH / 2).abs();
      final bd = (shelfCenter(plan, best) - plan.ringH / 2).abs();
      if (d < bd) best = k;
    }
    return best;
  }

  /// Height from the bottom of the unit to the bottom edge of the unit piece
  /// in row [row], measured on the face that touches the unit.
  double bottomEdge(Plan plan, int row) {
    final k = shelfFor(plan, row);
    if (k != null) return shelfCenter(plan, k) - Limits.anchorCleatW / 2;
    return row == 0 ? plan.ringH - Limits.anchorCleatW : plan.dimensions.kick;
  }

  /// Height of the bottom of the unit above the floor: zero when it rests on
  /// the floor, the planned height when a wall is set, otherwise null.
  double? unitBottomAboveFloor(Plan plan) {
    final i = plan.inputs;
    if (i.onFloor) return 0;
    final window = i.windowBottomOnWall;
    if (window == null) return null;
    return math.max(0, window - i.insetBottom - i.bottom);
  }
}
