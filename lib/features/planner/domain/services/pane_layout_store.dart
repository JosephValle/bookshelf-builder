import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';

/// Port for remembering the pane widths between sessions.
///
/// Implementations must never throw.
abstract class PaneLayoutStore {
  /// Returns the saved widths, or null when nothing valid is saved.
  Future<PaneWidths?> load();

  /// Saves [widths].
  Future<void> save(PaneWidths widths);

  /// Forgets the saved widths.
  Future<void> clear();
}
