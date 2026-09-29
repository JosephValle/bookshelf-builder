import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';

/// Records exported plans instead of opening a print dialog.
class FakePdfExporter implements PdfExporter {
  /// Plans exported so far.
  final List<Plan> exported = [];

  /// When true, [export] and [save] throw.
  bool fail = false;

  /// Whether [canSave] reports true.
  bool saveSupported = true;

  /// Path [save] returns, or null to act as if the user cancelled.
  String? savePath = '/tmp/shelf_planner.pdf';

  /// Plans saved so far.
  final List<Plan> saved = [];

  /// Paths shown in the file manager so far.
  final List<String> revealed = [];

  @override
  bool get canSave => saveSupported;

  @override
  Future<void> export(Plan plan) async {
    if (fail) throw StateError('pdf unavailable');
    exported.add(plan);
  }

  @override
  Future<String?> save(Plan plan) async {
    if (fail) throw StateError('pdf unavailable');
    saved.add(plan);
    return savePath;
  }

  @override
  Future<void> reveal(String path) async {
    if (fail) throw StateError('finder unavailable');
    revealed.add(path);
  }
}
