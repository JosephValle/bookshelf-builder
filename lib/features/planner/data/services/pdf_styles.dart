import 'package:bookshelf_builder/app/theme/app_colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Colors and text styles shared by the styled PDF sections, matching the
/// cards on the Materials tab.
class PdfStyles {
  const PdfStyles._();

  /// Accent color for card titles and markers (the wood brown).
  static final PdfColor accent = PdfColor.fromInt(AppColors.wood.toARGB32());

  /// Border color of a card.
  static const PdfColor border = PdfColor.fromInt(0xFFB8A99A);

  /// Background of a small chip.
  static const PdfColor chipFill = PdfColor.fromInt(0xFFF3ECE3);

  /// Muted text color for captions and explanations.
  static const PdfColor muted = PdfColor.fromInt(0xFF5F564D);

  /// Fill of a 3/4" plywood piece in an assembly diagram.
  static const PdfColor diagramPanel = PdfColor.fromInt(0xFF8B6B4A);

  /// Fill of a 1/4" back panel in an assembly diagram.
  static const PdfColor diagramBack = PdfColor.fromInt(0xFFD9C3A5);

  /// Fill of a cleat or a divider band in an assembly diagram.
  static const PdfColor diagramCleat = PdfColor.fromInt(0xFFE8C98A);

  /// Fill of the wall in an assembly diagram.
  static const PdfColor diagramWall = PdfColor.fromInt(0xFFCFCFCF);

  /// Fill of a reference-only shape in an assembly diagram.
  static const PdfColor diagramGhost = PdfColor.fromInt(0xFFF3ECE3);

  /// Outline of every diagram shape and the ink of fasteners and arrows.
  static const PdfColor diagramInk = PdfColor.fromInt(0xFF2B2118);

  /// Color of measurement lines and their text.
  static const PdfColor diagramDim = PdfColor.fromInt(0xFF1B4F72);

  /// Corner radius of cards and chips.
  static const double radius = 6;

  /// Card title.
  static final pw.TextStyle cardTitle = pw.TextStyle(
    fontSize: 13,
    fontWeight: pw.FontWeight.bold,
    color: accent,
  );

  /// Bold body text.
  static const pw.TextStyle strong = pw.TextStyle(
    fontSize: 10.5,
    fontWeight: pw.FontWeight.bold,
  );

  /// Regular body text.
  static const pw.TextStyle body = pw.TextStyle(fontSize: 10.5);

  /// Caption and explanation text.
  static const pw.TextStyle caption = pw.TextStyle(fontSize: 9, color: muted);

  /// The larger, bold style used for totals.
  static const pw.TextStyle total = pw.TextStyle(
    fontSize: 13,
    fontWeight: pw.FontWeight.bold,
  );
}
