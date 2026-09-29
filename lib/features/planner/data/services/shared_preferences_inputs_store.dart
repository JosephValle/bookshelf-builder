import 'dart:convert';

import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inputs_codec.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inputs_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Saves the inputs as JSON in `shared_preferences` (browser local storage on
/// the web, user defaults on macOS). Every method swallows storage errors.
class SharedPreferencesInputsStore implements InputsStore {
  /// Creates a store.
  const SharedPreferencesInputsStore({this.codec = const InputsCodec()});

  /// Key the JSON is saved under.
  static const String key = 'shelf_planner.inputs.v1';

  /// Converts inputs to and from JSON maps.
  final InputsCodec codec;

  @override
  Future<Inputs?> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(key);
      if (raw == null) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, Object?>) return null;
      return codec.decode(decoded);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(Inputs inputs) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, jsonEncode(codec.encode(inputs)));
    } catch (_) {}
  }

  @override
  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (_) {}
  }
}
