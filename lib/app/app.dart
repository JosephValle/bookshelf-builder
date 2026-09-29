import 'package:bookshelf_builder/app/theme/app_theme.dart';
import 'package:bookshelf_builder/features/planner/data/services/printing_pdf_exporter.dart';
import 'package:bookshelf_builder/features/planner/data/services/shared_preferences_inputs_store.dart';
import 'package:bookshelf_builder/features/planner/data/services/system_clipboard_writer.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/clipboard_writer.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inputs_store.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/screens/planner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Root widget. Wires the planner cubit to its platform implementations,
/// which tests can replace.
class ShelfPlannerApp extends StatelessWidget {
  /// Creates the app.
  const ShelfPlannerApp({
    this.clipboard = const SystemClipboardWriter(),
    this.pdfExporter = const PrintingPdfExporter(),
    this.store = const SharedPreferencesInputsStore(),
    this.initial = const Inputs(),
    super.key,
  });

  /// Clipboard implementation.
  final ClipboardWriter clipboard;

  /// PDF export implementation.
  final PdfExporter pdfExporter;

  /// Where the last inputs are saved.
  final InputsStore store;

  /// Inputs to start from (the saved ones, loaded before the app starts).
  final Inputs initial;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlannerCubit(
        clipboard: clipboard,
        pdfExporter: pdfExporter,
        store: store,
        initial: initial,
      ),
      child: MaterialApp(
        title: 'Shelf Planner',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const PlannerScreen(),
      ),
    );
  }
}
