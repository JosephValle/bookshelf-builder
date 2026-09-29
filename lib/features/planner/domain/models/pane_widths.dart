import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pane_widths.freezed.dart';

/// Preferred widths of the inputs and results panes. The drawing pane takes
/// whatever width is left.
@freezed
abstract class PaneWidths with _$PaneWidths {
  /// Creates widths, defaulting to the standard layout.
  const factory PaneWidths({
    /// Width of the inputs pane.
    @Default(PaneLimits.defaultInputs) double inputs,

    /// Width of the results pane.
    @Default(PaneLimits.defaultResults) double results,
  }) = _PaneWidths;
}
