import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/fasteners.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';

/// Counts the screws and brads a plan needs, so the guide can tell you how
/// many to buy. Counts are rounded up and are estimates, not exact.
class FastenerCounter {
  /// Creates a counter.
  const FastenerCounter();

  /// 1-1/4" screws for one column: shelf ends and divider ends.
  int columnScrews(Plan plan, ColumnPlan c) {
    final joints = c.shelves * 2 + c.dividers * (c.shelves + 1) * 2;
    return joints * Fasteners.screwsPerJoint(plan.depthPanel);
  }

  /// 1-1/4" screws for one bar: divider ends and, when it has two tiers, the
  /// ends of the middle shelves.
  int barScrews(Plan plan, BarPlan b) {
    var joints = b.dividers * 2;
    if (b.tiers == 2) joints += (b.dividers + 1) * 2;
    return joints * Fasteners.screwsPerJoint(plan.depthPanel);
  }

  /// 1-1/4" screws that join the two bars to the two columns: the column
  /// panel ends into the top and bottom panels, and the column panels into
  /// the bar ends.
  int ringScrews(Plan plan) =>
      (12 + (plan.leftCol.dividers + plan.rightCol.dividers) * 2) *
      Fasteners.screwsPerJoint(plan.depthPanel);

  /// 1-1/4" screws holding the toe kick.
  int toeKickScrews(Plan plan) =>
      (plan.ringW / Fasteners.toeKickSpacing).ceil();

  /// 1" brads for the four 1/4" backs: every edge plus every shelf and
  /// divider they cover.
  int backBrads(Plan plan) {
    final i = plan.inputs;
    var run =
        2 * (plan.ringH + i.left) +
        2 * (plan.ringH + i.right) +
        2 * (i.openW + i.top) +
        2 * (i.openW + i.bottom);
    for (final c in [plan.leftCol, plan.rightCol]) {
      run += c.shelves * c.colW + c.dividers * (c.shelves + 1) * c.clearH;
    }
    for (final b in [plan.topBar, plan.bottomBar]) {
      run += b.dividers * b.clearH;
      if (b.tiers == 2) run += (b.dividers + 1) * b.bayW;
    }
    return (run / Fasteners.nailSpacing).ceil();
  }

  /// Length of each unit French cleat piece: two rows on each column.
  List<double> cleatPieceLengths(Plan plan) => [
    plan.inputs.left,
    plan.inputs.left,
    plan.inputs.right,
    plan.inputs.right,
  ];

  /// Screws in cleat piece [index] (0 to 3): 2" screws for the unit half, or
  /// 3" screws for the wall half.
  int pieceScrews(Plan plan, int index, {required bool wall}) {
    final len = cleatPieceLengths(plan)[index];
    if (wall) return 2 * math.max(1, (len / Limits.studSpacing).ceil());
    final gaps = math.max(
      1,
      ((len - 2 * Fasteners.cleatEndInset) / Fasteners.screwSpacing).ceil(),
    );
    return gaps + 1;
  }

  /// 2" screws that hold the unit half of the French cleat.
  int unitCleatScrews(Plan plan) {
    var total = 0;
    for (final len in cleatPieceLengths(plan)) {
      final gaps = math.max(
        1,
        ((len - 2 * Fasteners.cleatEndInset) / Fasteners.screwSpacing).ceil(),
      );
      total += gaps + 1;
    }
    return total;
  }

  /// 3" screws for the wall half: two per stud, at least one stud a piece.
  int wallCleatScrews(Plan plan) {
    var total = 0;
    for (final len in cleatPieceLengths(plan)) {
      total += 2 * math.max(1, (len / Limits.studSpacing).ceil());
    }
    return total;
  }
}
