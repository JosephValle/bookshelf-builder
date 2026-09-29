import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';

/// Port for exporting a printable PDF of a plan.
abstract class PdfExporter {
  /// Opens the platform print or save dialog for [plan].
  Future<void> export(Plan plan);
}
