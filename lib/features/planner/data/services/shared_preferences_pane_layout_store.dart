import 'dart:convert';

import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pane_layout_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Saves the pane widths as JSON in `shared_preferences`. Every method
/// swallows storage errors.
class SharedPreferencesPaneLayoutStore implements PaneLayoutStore {
  /// Creates a store.
  const SharedPreferencesPaneLayoutStore();

  /// Key the JSON is saved under.
  static const String key = 'shelf_planner.panes.v1';

  @override
  Future<PaneWidths?> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(key);
      if (raw == null) return null;
      final m = jsonDecode(raw);
      if (m is! Map<String, Object?>) return null;
      final inputs = m['inputs'];
      final results = m['results'];
      if (inputs is! num || results is! num) return null;
      if (!inputs.isFinite || !results.isFinite) return null;
      if (inputs <= 0 || results <= 0) return null;
      return PaneWidths(inputs: inputs.toDouble(), results: results.toDouble());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(PaneWidths widths) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        key,
        jsonEncode({'inputs': widths.inputs, 'results': widths.results}),
      );
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
