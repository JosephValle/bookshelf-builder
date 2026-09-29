import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';

/// Port for exporting a printable PDF of a plan.
abstract class PdfExporter {
  /// Opens the platform print or save dialog for [plan].
  Future<void> export(Plan plan);

  /// True when the platform can save the PDF to a file the app knows the
  /// location of, so it can be shown in the file manager afterwards.
  bool get canSave;

  /// Asks where to save the PDF of [plan], writes it there, and returns the
  /// path. Returns null when the user cancels.
  Future<String?> save(Plan plan);

  /// Shows the file at [path] in the platform file manager (Finder on macOS).
  Future<void> reveal(String path);
}
