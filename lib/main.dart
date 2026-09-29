import 'package:bookshelf_builder/app/app.dart';
import 'package:bookshelf_builder/features/planner/data/services/shared_preferences_inputs_store.dart';
import 'package:bookshelf_builder/features/planner/data/services/shared_preferences_pane_layout_store.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const store = SharedPreferencesInputsStore();
  const paneStore = SharedPreferencesPaneLayoutStore();
  final saved = await store.load();
  final panes = await paneStore.load();
  runApp(
    ShelfPlannerApp(
      store: store,
      initial: saved ?? Inputs.home,
      paneStore: paneStore,
      initialPanes: panes ?? const PaneWidths(),
    ),
  );
}
