import 'package:bookshelf_builder/features/planner/data/services/shared_preferences_inputs_store.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const store = SharedPreferencesInputsStore();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('SharedPreferencesInputsStore', () {
    test('load returns null when nothing is saved', () async {
      expect(await store.load(), isNull);
    });

    test('save then load returns the same inputs', () async {
      const i = Inputs(windowW: 40, wallW: 120, gapTop: 2);
      await store.save(i);
      expect(await store.load(), i);
    });

    test('save overwrites the previous value', () async {
      await store.save(const Inputs(windowW: 40));
      await store.save(const Inputs(windowW: 44));
      expect((await store.load())!.windowW, 44);
    });

    test('clear forgets the saved inputs', () async {
      await store.save(const Inputs(windowW: 40));
      await store.clear();
      expect(await store.load(), isNull);
    });

    test('clear with nothing saved is fine', () async {
      await store.clear();
      expect(await store.load(), isNull);
    });

    test('corrupt JSON loads as null', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesInputsStore.key: '{not json',
      });
      expect(await store.load(), isNull);
    });

    test('JSON that is not an object loads as null', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesInputsStore.key: '[1, 2, 3]',
      });
      expect(await store.load(), isNull);
    });

    test('a damaged value falls back to defaults for that field', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesInputsStore.key: '{"windowW": "wide", "left": 20}',
      });
      final i = await store.load();
      expect(i!.windowW, 48);
      expect(i.left, 20);
    });

    test('a value saved under a different type loads as null', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesInputsStore.key: 5,
      });
      expect(await store.load(), isNull);
    });
  });
}
