import 'package:bookshelf_builder/features/planner/data/services/shared_preferences_pane_layout_store.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const store = SharedPreferencesPaneLayoutStore();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<PaneWidths?> loadWith(Object? value) {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesPaneLayoutStore.key: ?value,
    });
    return store.load();
  }

  group('SharedPreferencesPaneLayoutStore', () {
    test('load returns null when nothing is saved', () async {
      expect(await store.load(), isNull);
    });

    test('save then load returns the same widths', () async {
      await store.save(const PaneWidths(inputs: 300, results: 410));
      expect(await store.load(), const PaneWidths(inputs: 300, results: 410));
    });

    test('clear forgets the saved widths', () async {
      await store.save(const PaneWidths(inputs: 300));
      await store.clear();
      expect(await store.load(), isNull);
    });

    test('corrupt JSON loads as null', () async {
      expect(await loadWith('{oops'), isNull);
    });

    test('a JSON array loads as null', () async {
      expect(await loadWith('[1,2]'), isNull);
    });

    test('missing fields load as null', () async {
      expect(await loadWith('{"inputs": 300}'), isNull);
    });

    test('non-numeric fields load as null', () async {
      expect(await loadWith('{"inputs": "a", "results": 300}'), isNull);
    });

    test('non-positive widths load as null', () async {
      expect(await loadWith('{"inputs": 0, "results": 300}'), isNull);
      expect(await loadWith('{"inputs": 300, "results": -5}'), isNull);
    });

    test('a value of the wrong type loads as null', () async {
      expect(await loadWith(7), isNull);
    });
  });
}
