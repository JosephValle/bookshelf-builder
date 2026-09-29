import 'dart:math';

import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';

/// Computes how many vertical dividers a horizontal run needs.
class DividerCalculator {
  /// Creates a calculator.
  const DividerCalculator();

  /// Dividers needed so no clear span in a run of [length] exceeds [span].
  ///
  /// `d = max(0, ceil((length - span) / (span + t)))`.
  int count(double length, double span) =>
      max(0, ((length - span) / (span + Limits.t)).ceil());

  /// Clear bay width for a run of [length] split by [dividers] dividers.
  double bayWidth(double length, int dividers) =>
      (length - dividers * Limits.t) / (dividers + 1);
}
