import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:equatable/equatable.dart';

/// Preferred widths of the inputs and results panes. The drawing pane takes
/// whatever width is left.
class PaneWidths extends Equatable {
  /// Creates widths, defaulting to the standard layout.
  const PaneWidths({
    this.inputs = PaneLimits.defaultInputs,
    this.results = PaneLimits.defaultResults,
  });

  /// Width of the inputs pane.
  final double inputs;

  /// Width of the results pane.
  final double results;

  @override
  List<Object?> get props => [inputs, results];
}
