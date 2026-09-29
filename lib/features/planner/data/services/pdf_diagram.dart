import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/data/services/pdf_styles.dart';
import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_dimension.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark_kind.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_tone.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Draws an [AssemblyDiagram] into the PDF: the pieces-you-need strip, the
/// picture with its piece ids, arrows, screws and measurement lines, and the
/// caption.
class PdfDiagram {
  const PdfDiagram._();

  static const double _maxW = 330;
  static const double _maxH = 210;

  static PdfColor _fill(DiagramTone tone) => switch (tone) {
    DiagramTone.panel => PdfStyles.diagramPanel,
    DiagramTone.back => PdfStyles.diagramBack,
    DiagramTone.cleat => PdfStyles.diagramCleat,
    DiagramTone.wall => PdfStyles.diagramWall,
    DiagramTone.ghost => PdfStyles.diagramGhost,
  };

  static PdfColor _ink(DiagramTone tone) =>
      tone == DiagramTone.panel ? PdfColors.white : PdfStyles.diagramInk;

  /// Builds the widget for [d].
  static pw.Widget build(AssemblyDiagram d) {
    final s = math.min(_maxW / d.width, _maxH / d.height);
    final w = d.width * s;
    final h = d.height * s;
    pw.Widget text(
      String t,
      double cx,
      double cy,
      pw.TextStyle style, {
      double boxW = 44,
      double dx = 0,
      double dy = 0,
    }) => pw.Positioned(
      left: cx * s - boxW / 2 + dx,
      top: cy * s - style.fontSize! / 2 - 1 + dy,
      child: pw.SizedBox(
        width: boxW,
        child: pw.Center(child: pw.Text(t, style: style)),
      ),
    );
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (d.pieces.isNotEmpty) _pieces(d.pieces),
        pw.Container(
          width: w + 40,
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfStyles.border, width: 0.6),
            borderRadius: pw.BorderRadius.circular(PdfStyles.radius),
          ),
          child: pw.SizedBox(
            // Extra room on the right for vertical measurement text.
            width: w + 24,
            height: h,
            child: pw.Stack(
              children: [
                pw.CustomPaint(
                  size: PdfPoint(w, h),
                  painter: (canvas, size) => _paint(canvas, d, s, h),
                ),
                for (final shape in d.shapes)
                  if (shape.label.isNotEmpty)
                    text(
                      shape.label,
                      shape.center.x,
                      shape.center.y,
                      pw.TextStyle(
                        fontSize: shape.label.length > 3 ? 6.5 : 8,
                        fontWeight: pw.FontWeight.bold,
                        color: _ink(shape.tone),
                      ),
                    ),
                for (final dim in d.dimensions)
                  text(
                    dim.text,
                    (dim.from.x + dim.to.x) / 2,
                    (dim.from.y + dim.to.y) / 2,
                    const pw.TextStyle(
                      fontSize: 7.5,
                      color: PdfStyles.diagramDim,
                    ),
                    boxW: 50,
                    // Keep the text clear of its own line: above a horizontal
                    // line, to the right of a vertical one.
                    dx: _horizontal(dim) ? 0 : 14,
                    dy: _horizontal(dim) ? -7 : 0,
                  ),
              ],
            ),
          ),
        ),
        pw.SizedBox(height: 3),
        pw.SizedBox(
          width: math.max(w + 16, 300),
          child: pw.Text(d.caption, style: PdfStyles.caption),
        ),
      ],
    );
  }

  static bool _horizontal(DiagramDimension dim) =>
      (dim.to.x - dim.from.x).abs() >= (dim.to.y - dim.from.y).abs();

  static pw.Widget _pieces(List<DiagramPiece> pieces) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 4),
    child: pw.Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        for (final p in pieces)
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: pw.BoxDecoration(
              color: PdfStyles.chipFill,
              border: pw.Border.all(color: PdfStyles.border, width: 0.5),
              borderRadius: pw.BorderRadius.circular(3),
            ),
            child: pw.Text(
              [
                if (p.qty > 0) '${p.qty}x',
                if (p.label.isNotEmpty) p.label,
                p.name,
              ].join(' '),
              style: PdfStyles.body,
            ),
          ),
      ],
    ),
  );

  static void _paint(
    PdfGraphics canvas,
    AssemblyDiagram d,
    double s,
    double h,
  ) {
    double x(double v) => v * s;
    double y(double v) => h - v * s;
    for (final shape in d.shapes) {
      final pts = shape.points;
      canvas
        ..setFillColor(_fill(shape.tone))
        ..setStrokeColor(PdfStyles.diagramInk)
        ..setLineWidth(0.6)
        ..moveTo(x(pts.first.x), y(pts.first.y));
      for (final p in pts.skip(1)) {
        canvas.lineTo(x(p.x), y(p.y));
      }
      canvas
        ..closePath()
        ..fillAndStrokePath();
    }
    for (final dim in d.dimensions) {
      canvas
        ..setStrokeColor(PdfStyles.diagramDim)
        ..setLineWidth(0.5)
        ..moveTo(x(dim.from.x), y(dim.from.y))
        ..lineTo(x(dim.to.x), y(dim.to.y))
        ..strokePath();
      final horizontal = _horizontal(dim);
      for (final e in [dim.from, dim.to]) {
        canvas
          ..moveTo(
            horizontal ? x(e.x) : x(e.x) - 2.5,
            horizontal ? y(e.y) - 2.5 : y(e.y),
          )
          ..lineTo(
            horizontal ? x(e.x) : x(e.x) + 2.5,
            horizontal ? y(e.y) + 2.5 : y(e.y),
          )
          ..strokePath();
      }
    }
    for (final a in d.arrows) {
      final dx = a.to.x - a.from.x;
      final dy = a.to.y - a.from.y;
      final len = math.sqrt(dx * dx + dy * dy);
      if (len == 0) continue;
      final ux = dx / len;
      final uy = dy / len;
      const head = 5.0;
      final bx = a.to.x - ux * head;
      final by = a.to.y - uy * head;
      canvas
        ..setStrokeColor(PdfStyles.diagramInk)
        ..setFillColor(PdfStyles.diagramInk)
        ..setLineWidth(1)
        ..moveTo(x(a.from.x), y(a.from.y))
        ..lineTo(x(bx), y(by))
        ..strokePath()
        ..moveTo(x(a.to.x), y(a.to.y))
        ..lineTo(x(bx - uy * 2.5), y(by + ux * 2.5))
        ..lineTo(x(bx + uy * 2.5), y(by - ux * 2.5))
        ..closePath()
        ..fillPath();
    }
    for (final m in d.marks) {
      final cx = x(m.at.x);
      final cy = y(m.at.y);
      if (m.kind == DiagramMarkKind.nail) {
        canvas
          ..setFillColor(PdfStyles.diagramInk)
          ..drawEllipse(cx, cy, 1.5, 1.5)
          ..fillPath();
      } else {
        canvas
          ..setFillColor(PdfColors.white)
          ..setStrokeColor(PdfStyles.diagramInk)
          ..setLineWidth(0.7)
          ..drawEllipse(cx, cy, 2.8, 2.8)
          ..fillAndStrokePath()
          ..moveTo(cx - 1.9, cy)
          ..lineTo(cx + 1.9, cy)
          ..moveTo(cx, cy - 1.9)
          ..lineTo(cx, cy + 1.9)
          ..strokePath();
      }
    }
  }
}
