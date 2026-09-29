import 'dart:typed_data';

import 'package:bookshelf_builder/app/theme/app_colors.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_diagram.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_material_sections.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_step.dart';
import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_guide_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Builds the printable PDF for a plan: drawing, cut list, materials,
/// warnings, wall note and disclaimer.
class PdfDocumentBuilder {
  /// Creates a builder.
  const PdfDocumentBuilder({
    this.formatter = const InchesFormatter(),
    this.guide = const AssemblyGuideBuilder(),
    this.sections = const PdfMaterialSections(),
    this.compress = true,
  });

  /// Inch formatting used throughout the document.
  final InchesFormatter formatter;

  /// Writes the assembly guide section.
  final AssemblyGuideBuilder guide;

  /// Builds the styled materials cards.
  final PdfMaterialSections sections;

  /// Whether to compress the PDF streams. Tests turn it off so the text can
  /// be searched.
  final bool compress;

  static const double _drawingMaxW = 460;
  static const double _drawingMaxH = 400;
  static const double _margin = 36;

  static PdfColor _pdf(int argb) => PdfColor.fromInt(argb);

  /// Returns the bytes of the finished PDF.
  Future<Uint8List> build(Plan plan) async {
    final doc = pw.Document(compress: compress);
    final f = formatter.format;
    final i = plan.inputs;
    const heading = pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold);

    final rows = <List<String>>[
      ['Piece', 'Part', 'Qty', 'Length', 'Width', 'Material'],
      for (final p in plan.parts)
        [
          p.idRange,
          p.name,
          '${p.qty}',
          formatter.partLength(p),
          p.material == PartMaterial.edgeBand ? '' : f(p.width),
          p.material.label,
        ],
    ];

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(_margin),
        build: (ctx) => [
          pw.Text(
            'Shelf Planner',
            style: const pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Ring ${f(plan.ringW)} wide by ${f(plan.ringH)} tall, ${f(i.depth)} deep. '
            'Window ${f(i.windowW)} by ${f(i.windowH)}.',
          ),
          pw.SizedBox(height: 12),
          pw.Center(child: _drawing(plan)),
          pw.SizedBox(height: 16),
          pw.Text('Cut list', style: heading),
          pw.SizedBox(height: 6),
          pw.TableHelper.fromTextArray(
            data: rows,
            headerStyle: const pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 10),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          ),
          pw.SizedBox(height: 16),
          pw.Text('Materials', style: heading),
          pw.SizedBox(height: 6),
          ...sections.all(plan),
          pw.SizedBox(height: 10),
          pw.Text('Assembly guide', style: heading),
          pw.SizedBox(height: 6),
          ..._assembly(plan),
          pw.SizedBox(height: 10),
          pw.Text('Where every piece goes', style: heading),
          pw.SizedBox(height: 6),
          ..._pieceMap(plan),
          pw.SizedBox(height: 16),
          pw.Text('Warnings', style: heading),
          pw.SizedBox(height: 6),
          if (plan.issues.isEmpty) pw.Text('None'),
          for (final issue in plan.issues) pw.Bullet(text: issue.message),
          pw.SizedBox(height: 16),
          pw.Text(
            PlannerNotes.disclaimer,
            style: const pw.TextStyle(fontSize: 9),
          ),
        ],
      ),
    );
    return doc.save();
  }

  List<pw.Widget> _assembly(Plan plan) {
    final steps = guide.build(plan);
    return [
      for (var n = 0; n < steps.length; n++) PdfStep.build(n + 1, steps[n]),
    ];
  }

  List<pw.Widget> _pieceMap(Plan plan) => [
    for (final d in guide.pieceMap(plan))
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: PdfDiagram.build(d),
      ),
  ];

  pw.Widget _drawing(Plan plan) {
    final scaleW = _drawingMaxW / plan.ringW;
    final scaleH = _drawingMaxH / plan.ringH;
    final s = scaleW < scaleH ? scaleW : scaleH;
    final w = plan.ringW * s;
    final h = plan.ringH * s;
    final wood = _pdf(AppColors.wood.toARGB32());
    final kick = _pdf(AppColors.kickWood.toARGB32());
    final window = _pdf(AppColors.window.toARGB32());
    final geo = plan.geometry;
    return pw.SizedBox(
      width: w,
      height: h,
      child: pw.CustomPaint(
        size: PdfPoint(w, h),
        painter: (canvas, size) {
          void fill(Box b, PdfColor color) {
            canvas
              ..setFillColor(color)
              ..drawRect(b.x * s, h - (b.y + b.h) * s, b.w * s, b.h * s)
              ..fillPath();
          }

          fill(geo.windowBox, window);
          for (final p in geo.panels) {
            fill(p, wood);
          }
          if (geo.toeKickBox != null) fill(geo.toeKickBox!, kick);
          for (final bay in geo.bays.where((b) => b.bad)) {
            final b = bay.box;
            canvas
              ..setStrokeColor(PdfColors.red)
              ..setLineWidth(1.5)
              ..drawRect(b.x * s, h - (b.y + b.h) * s, b.w * s, b.h * s)
              ..strokePath();
          }
        },
      ),
    );
  }
}
