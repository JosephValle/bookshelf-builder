import 'package:bookshelf_builder/app/app.dart';
import 'package:bookshelf_builder/features/planner/data/services/shared_preferences_inputs_store.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const store = SharedPreferencesInputsStore();
  final saved = await store.load();
  runApp(ShelfPlannerApp(store: store, initial: saved ?? const Inputs()));
}
