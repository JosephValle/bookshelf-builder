import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pane_layout_store.dart';

/// In-memory [PaneLayoutStore] that records what was saved and cleared.
class FakePaneLayoutStore implements PaneLayoutStore {
  /// Creates a store, optionally holding [saved] already.
  FakePaneLayoutStore({this.saved});

  /// The currently saved widths.
  PaneWidths? saved;

  /// Every saved value in order.
  final List<PaneWidths> saves = [];

  /// How many times [clear] was called.
  int clears = 0;

  @override
  Future<PaneWidths?> load() async => saved;

  @override
  Future<void> save(PaneWidths widths) async {
    saved = widths;
    saves.add(widths);
  }

  @override
  Future<void> clear() async {
    saved = null;
    clears++;
  }
}
