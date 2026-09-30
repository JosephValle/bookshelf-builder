import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/fasteners.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';

/// Counts the screws and brads a plan needs, so the guide can tell you how
/// many to buy. Counts are rounded up and are estimates, not exact.
class FastenerCounter {
  /// Creates a counter.
  const FastenerCounter();

  /// All the box screws (#8 x 1-1/4") in the unit: columns, bars, the joins
  /// between them and the toe kick.
  int boxScrews(Plan plan) =>
      columnScrews(plan, plan.leftCol) +
      columnScrews(plan, plan.rightCol) +
      barScrews(plan, plan.topBar) +
      barScrews(plan, plan.bottomBar) +
      ringScrews(plan) +
      toeKickScrews(plan);

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

  /// 1" brads for back panel [index] (0 left column, 1 right column, 2 top
  /// bar, 3 bottom bar): every edge plus every shelf and divider behind it.
  int backPanelBrads(Plan plan, int index) {
    final i = plan.inputs;
    double run;
    if (index < 2) {
      final c = index == 0 ? plan.leftCol : plan.rightCol;
      final w = index == 0 ? i.left : i.right;
      run =
          2 * (plan.ringH + w) +
          c.shelves * c.colW +
          c.dividers * (c.shelves + 1) * c.clearH;
    } else {
      final b = index == 2 ? plan.topBar : plan.bottomBar;
      final h = index == 2 ? i.top : i.bottom;
      run = 2 * (i.openW + h) + b.dividers * b.clearH;
      if (b.tiers == 2) run += (b.dividers + 1) * b.bayW;
    }
    return (run / Fasteners.nailSpacing).ceil();
  }

  /// 1" brads for all four 1/4" backs.
  int backBrads(Plan plan) {
    var total = 0;
    for (var k = 0; k < 4; k++) {
      total += backPanelBrads(plan, k);
    }
    return total;
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
    if (wall) return wallPieceScrews(plan, len);
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

  /// Screws for one wall cleat piece of length [len].
  ///
  /// On a stud wall that is two 3" screws per stud (at least one stud a
  /// piece). On a concrete wall it is pairs of concrete screws, one pair
  /// [Fasteners.concreteEndInset] from each end and another at least every
  /// [Fasteners.concreteSpacing] between.
  int wallPieceScrews(Plan plan, double len) {
    if (plan.inputs.concreteWall) {
      final gaps = math.max(
        1,
        ((len - 2 * Fasteners.concreteEndInset) / Fasteners.concreteSpacing)
            .ceil(),
      );
      return 2 * (gaps + 1);
    }
    return 2 * math.max(1, (len / plan.inputs.studSpacing).ceil());
  }

  /// Screws for the whole wall half: 3" screws on a stud wall, concrete
  /// screws on a concrete wall.
  int wallCleatScrews(Plan plan) {
    var total = 0;
    for (final len in cleatPieceLengths(plan)) {
      total += wallPieceScrews(plan, len);
    }
    return total;
  }
}
