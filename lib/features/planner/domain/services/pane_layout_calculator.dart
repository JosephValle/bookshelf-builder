import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';

/// Keeps the pane widths inside their minimums for the available width, and
/// turns divider drags into new widths.
class PaneLayoutCalculator {
  /// Creates a calculator.
  const PaneLayoutCalculator();

  /// Fits [widths] into [total] pixels, leaving [dividers] pixels for the
  /// dividers.
  ///
  /// Each side pane keeps at least its minimum and the drawing keeps at least
  /// its minimum. When [total] is too small for all three minimums the
  /// minimums win.
  PaneWidths fit(PaneWidths widths, double total, double dividers) {
    final room = total - dividers;
    final maxInputs = room - PaneLimits.minDrawing - PaneLimits.minResults;
    final inputs = widths.inputs
        .clamp(PaneLimits.minInputs, math.max(PaneLimits.minInputs, maxInputs))
        .toDouble();
    final maxResults = room - PaneLimits.minDrawing - inputs;
    final results = widths.results
        .clamp(
          PaneLimits.minResults,
          math.max(PaneLimits.minResults, maxResults),
        )
        .toDouble();
    return PaneWidths(inputs: inputs, results: results);
  }

  /// Width left for the drawing.
  double drawing(PaneWidths widths, double total, double dividers) =>
      total - dividers - widths.inputs - widths.results;

  /// Moves the divider after the inputs pane by [delta] pixels (positive is
  /// to the right).
  PaneWidths dragInputs(
    PaneWidths widths,
    double delta,
    double total,
    double dividers,
  ) {
    final current = fit(widths, total, dividers);
    return fit(
      PaneWidths(inputs: current.inputs + delta, results: current.results),
      total,
      dividers,
    );
  }

  /// Moves the divider before the results pane by [delta] pixels (positive is
  /// to the right, which shrinks the results pane).
  PaneWidths dragResults(
    PaneWidths widths,
    double delta,
    double total,
    double dividers,
  ) {
    final current = fit(widths, total, dividers);
    return fit(
      PaneWidths(inputs: current.inputs, results: current.results - delta),
      total,
      dividers,
    );
  }
}
