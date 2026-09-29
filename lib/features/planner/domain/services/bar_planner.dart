import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/services/divider_calculator.dart';

/// Plans the dividers and tiers of the top or bottom bar.
class BarPlanner {
  /// Creates a planner.
  const BarPlanner({this.dividers = const DividerCalculator()});

  /// Divider math.
  final DividerCalculator dividers;

  /// Plans a bar of outer height [barH] spanning [windowW].
  ///
  /// [kick] is subtracted from the height (bottom bar on the floor). [span] is
  /// the divider spacing limit: the box beam limit for a bar with nothing
  /// under it, or the shelf span limit for a bar that rests on the floor.
  BarPlan plan({
    required double windowW,
    required double barH,
    required double kick,
    required double span,
  }) {
    final d = dividers.count(windowW, span);
    final clearH = barH - kick - 2 * Limits.t;
    final tiers = clearH >= 2 * Limits.minClearH + Limits.t ? 2 : 1;
    return BarPlan(
      dividers: d,
      dividerLength: clearH,
      bayW: dividers.bayWidth(windowW, d),
      clearH: clearH,
      tiers: tiers,
    );
  }
}
