import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inputs_store.dart';

/// In-memory [InputsStore] that records what was saved and cleared.
class FakeInputsStore implements InputsStore {
  /// Creates a store, optionally holding [saved] already.
  FakeInputsStore({this.saved});

  /// The currently saved inputs.
  Inputs? saved;

  /// Every saved value in order.
  final List<Inputs> saves = [];

  /// How many times [clear] was called.
  int clears = 0;

  @override
  Future<Inputs?> load() async => saved;

  @override
  Future<void> save(Inputs inputs) async {
    saved = inputs;
    saves.add(inputs);
  }

  @override
  Future<void> clear() async {
    saved = null;
    clears++;
  }
}
