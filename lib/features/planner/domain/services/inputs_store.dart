import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';

/// Port for remembering the last inputs between sessions.
///
/// Implementations must never throw: a failed load returns null and a failed
/// save or clear is ignored.
abstract class InputsStore {
  /// Returns the saved inputs, or null when nothing valid is saved.
  Future<Inputs?> load();

  /// Saves [inputs] as the latest state.
  Future<void> save(Inputs inputs);

  /// Forgets the saved inputs.
  Future<void> clear();
}
