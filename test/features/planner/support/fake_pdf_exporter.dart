import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';

/// Records exported plans instead of opening a print dialog.
class FakePdfExporter implements PdfExporter {
  /// Plans exported so far.
  final List<Plan> exported = [];

  /// When true, [export] throws.
  bool fail = false;

  @override
  Future<void> export(Plan plan) async {
    if (fail) throw StateError('pdf unavailable');
    exported.add(plan);
  }
}
