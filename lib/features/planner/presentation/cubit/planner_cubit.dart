import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/clipboard_writer.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cut_list_csv_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/plan_engine.dart';
import 'package:bookshelf_builder/features/planner/domain/services/summary_builder.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Holds the inputs, recomputes the plan on every change, and runs the
/// copy and export actions.
class PlannerCubit extends Cubit<PlannerState> {
  /// Creates a cubit starting from [initial] (default inputs when omitted).
  PlannerCubit({
    required this._clipboard,
    required this._pdfExporter,
    PlanEngine engine = const PlanEngine(),
    this._csvBuilder = const CutListCsvBuilder(),
    this._summaryBuilder = const SummaryBuilder(),
    Inputs initial = const Inputs(),
  }) : _engine = engine,
       super(PlannerState(inputs: initial, plan: engine.compute(initial)));

  final ClipboardWriter _clipboard;
  final PdfExporter _pdfExporter;
  final PlanEngine _engine;
  final CutListCsvBuilder _csvBuilder;
  final SummaryBuilder _summaryBuilder;

  /// Replaces the inputs and recomputes the plan.
  void setInputs(Inputs inputs) {
    if (inputs == state.inputs) return;
    emit(PlannerState(inputs: inputs, plan: _engine.compute(inputs)));
  }

  /// Applies [change] to the current inputs.
  void update(Inputs Function(Inputs current) change) =>
      setInputs(change(state.inputs));

  /// Restores the default inputs.
  void reset() => setInputs(const Inputs());

  /// Copies the cut list as CSV.
  Future<void> copyCsv() => _run(
    () => _clipboard.write(_csvBuilder.build(state.plan)),
    'Cut list copied as CSV',
    'Could not copy the cut list',
  );

  /// Copies the plain text summary.
  Future<void> copySummary() => _run(
    () => _clipboard.write(_summaryBuilder.build(state.plan)),
    'Summary copied',
    'Could not copy the summary',
  );

  /// Opens the PDF print or save dialog.
  Future<void> exportPdf() => _run(
    () => _pdfExporter.export(state.plan),
    'PDF ready',
    'Could not create the PDF',
  );

  Future<void> _run(
    Future<void> Function() action,
    String success,
    String failure,
  ) async {
    String message;
    try {
      await action();
      message = success;
    } catch (_) {
      message = failure;
    }
    emit(
      PlannerState(
        inputs: state.inputs,
        plan: state.plan,
        notice: message,
        noticeId: state.noticeId + 1,
      ),
    );
  }
}
