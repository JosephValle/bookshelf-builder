import 'dart:math' as math;

import 'package:bookshelf_builder/app/theme/app_colors.dart';
import 'package:bookshelf_builder/app/theme/app_type.dart';
import 'package:bookshelf_builder/app/theme/sizes.dart';
import 'package:bookshelf_builder/app/theme/strokes.dart';
import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:flutter/material.dart';

/// Draws the to-scale front elevation of a [Plan].
///
/// Panels use true thickness, the window is light blue, bays that break a
/// limit are outlined in red, and dimension lines mark the overall size, the
/// window and each bay. When wall inputs are set the wall outline is drawn
/// too.
class ElevationPainter extends CustomPainter {
  /// Creates a painter. [ink] colors lines and labels, [paper] backs labels.
  const ElevationPainter(this.plan, {required this.ink, required this.paper});

  /// Plan to draw.
  final Plan plan;

  /// Foreground color for dimension lines, labels and outlines.
  final Color ink;

  /// Background color for dimension label plates.
  final Color paper;

  static const InchesFormatter _fmt = InchesFormatter();

  @override
  void paint(Canvas canvas, Size size) {
    final i = plan.inputs;
    final ringW = plan.ringW;
    final ringH = plan.ringH;
    final wallW = i.wallW;
    final wallH = i.wallH;
    final offset = plan.ringOffsetOnWall ?? 0.0;
    final sceneLeft = wallW != null ? -offset : 0.0;
    final sceneRight = wallW != null ? wallW - offset : ringW;
    final sceneTop = wallH != null ? ringH - wallH : 0.0;
    final sceneW = (sceneRight - sceneLeft).clamp(1.0, double.infinity);
    final sceneH = (ringH - sceneTop).clamp(1.0, double.infinity);
    const pad = Sizes.drawingPadding;
    final sx = ((size.width - pad * 2) / sceneW).clamp(0.01, double.infinity);
    final sy = ((size.height - pad * 2) / sceneH).clamp(0.01, double.infinity);
    final s = sx < sy ? sx : sy;
    final ox = (size.width - sceneW * s) / 2 - sceneLeft * s;
    final oy = (size.height - sceneH * s) / 2 - sceneTop * s;

    Rect rect(Box b) =>
        Rect.fromLTWH(ox + b.x * s, oy + b.y * s, b.w * s, b.h * s);

    if (wallW != null || wallH != null) {
      canvas.drawRect(
        Rect.fromLTRB(
          ox + sceneLeft * s,
          oy + sceneTop * s,
          ox + sceneRight * s,
          oy + ringH * s,
        ),
        Paint()
          ..color = ink.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = Strokes.wall,
      );
    }
    if (wallW != null || wallH != null) {
      final wallTop = oy + sceneTop * s;
      final wallLeft = ox + sceneLeft * s;
      final wallRight = ox + sceneRight * s;
      final floorY = oy + ringH * s;
      final zones = <(Rect, String)>[
        if (wallW != null && i.wallMarginLeft > 0)
          (
            Rect.fromLTRB(
              wallLeft,
              wallTop,
              wallLeft + i.wallMarginLeft * s,
              floorY,
            ),
            _fmt.format(i.wallMarginLeft),
          ),
        if (wallW != null && i.wallMarginRight > 0)
          (
            Rect.fromLTRB(
              wallRight - i.wallMarginRight * s,
              wallTop,
              wallRight,
              floorY,
            ),
            _fmt.format(i.wallMarginRight),
          ),
        if (wallH != null && i.wallMarginTop > 0)
          (
            Rect.fromLTRB(
              wallLeft,
              wallTop,
              wallRight,
              wallTop + i.wallMarginTop * s,
            ),
            _fmt.format(i.wallMarginTop),
          ),
      ];
      for (final z in zones) {
        canvas.drawRect(
          z.$1,
          Paint()..color = AppColors.danger.withValues(alpha: 0.12),
        );
        _hatch(canvas, z.$1, AppColors.danger.withValues(alpha: 0.55));
        if (z.$1.width > 34 && z.$1.height > 16) {
          _text(
            canvas,
            'Keep clear ${z.$2}',
            z.$1.center,
            size: AppType.drawingBay,
            color: ink,
            maxW: z.$1.width - 4,
            plate: true,
          );
        }
      }
    }
    canvas.drawLine(
      Offset(ox + sceneLeft * s - 20, oy + ringH * s),
      Offset(ox + sceneRight * s + 20, oy + ringH * s),
      Paint()
        ..color = ink.withValues(alpha: 0.7)
        ..strokeWidth = Strokes.floor,
    );

    final geo = plan.geometry;
    final opening = rect(geo.openingBox);
    canvas.drawRect(opening, Paint()..color = AppColors.gap);
    _hatch(canvas, opening, AppColors.windowInk.withValues(alpha: 0.35));
    canvas.drawRect(rect(geo.windowBox), Paint()..color = AppColors.window);
    final gaps = <(double, Rect)>[
      (
        i.gapTop,
        Rect.fromLTRB(
          opening.left,
          opening.top,
          opening.right,
          rect(geo.windowBox).top,
        ),
      ),
      (
        i.gapBottom,
        Rect.fromLTRB(
          opening.left,
          rect(geo.windowBox).bottom,
          opening.right,
          opening.bottom,
        ),
      ),
      (
        i.gapLeft,
        Rect.fromLTRB(
          opening.left,
          opening.top,
          rect(geo.windowBox).left,
          opening.bottom,
        ),
      ),
      (
        i.gapRight,
        Rect.fromLTRB(
          rect(geo.windowBox).right,
          opening.top,
          opening.right,
          opening.bottom,
        ),
      ),
    ];
    for (final g in gaps) {
      if (g.$1 > 0 && g.$2.width > 26 && g.$2.height > 12) {
        _text(
          canvas,
          _fmt.plain(g.$1),
          g.$2.center,
          size: AppType.drawingBay,
          color: AppColors.windowInk,
          plate: true,
        );
      }
    }

    final wood = Paint()..color = AppColors.wood;
    final edge = Paint()
      ..color = ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = Strokes.panelEdge;
    for (final p in geo.panels) {
      final r = rect(p);
      canvas
        ..drawRect(r, wood)
        ..drawRect(r, edge);
    }
    final kick = geo.toeKickBox;
    if (kick != null) {
      canvas.drawRect(rect(kick), Paint()..color = AppColors.kickWood);
    }

    final danger = Paint()
      ..color = AppColors.danger
      ..style = PaintingStyle.stroke
      ..strokeWidth = Strokes.bad;
    for (final b in geo.bays) {
      final r = rect(b.box);
      if (b.bad) canvas.drawRect(r.deflate(1), danger);
      if (r.width > Sizes.minLabelBayW && r.height > Sizes.minLabelBayH) {
        _text(
          canvas,
          '${_fmt.plain(b.box.w)} x ${_fmt.plain(b.box.h)}',
          r.center,
          size: AppType.drawingBay,
          color: ink,
          maxW: math.max(0, r.width - 4),
        );
      }
    }

    final wr = rect(geo.windowBox);
    _text(
      canvas,
      'Window ${_fmt.plain(i.windowW)} x ${_fmt.plain(i.windowH)}',
      wr.center,
      size: AppType.drawingWindow,
      color: AppColors.windowInk,
      maxW: math.max(0, wr.width - 4),
    );

    final ring = Rect.fromLTWH(ox, oy, ringW * s, ringH * s);
    _hDim(
      canvas,
      ring.left,
      ring.right,
      ring.top - Sizes.dimOffset,
      _fmt.format(ringW),
    );
    _vDim(
      canvas,
      ring.top,
      ring.bottom,
      ring.left - Sizes.dimOffset,
      _fmt.format(ringH),
    );
    _hDim(
      canvas,
      wr.left,
      wr.right,
      ring.bottom + Sizes.dimOffset,
      'Window ${_fmt.format(i.windowW)}',
    );
    _vDim(
      canvas,
      wr.top,
      wr.bottom,
      ring.right + Sizes.dimOffset,
      'Window ${_fmt.format(i.windowH)}',
    );
  }

  void _hatch(Canvas c, Rect r, Color color) {
    const gap = 8.0;
    final p = Paint()
      ..color = color
      ..strokeWidth = 1;
    c
      ..save()
      ..clipRect(r);
    for (var d = -r.height; d < r.width; d += gap) {
      c.drawLine(
        Offset(r.left + d, r.bottom),
        Offset(r.left + d + r.height, r.top),
        p,
      );
    }
    c.restore();
  }

  void _hDim(Canvas c, double x1, double x2, double y, String label) {
    final p = Paint()
      ..color = ink
      ..strokeWidth = Strokes.dimension;
    const tick = Sizes.dimTick;
    c
      ..drawLine(Offset(x1, y), Offset(x2, y), p)
      ..drawLine(Offset(x1, y - tick), Offset(x1, y + tick), p)
      ..drawLine(Offset(x2, y - tick), Offset(x2, y + tick), p);
    _text(
      c,
      label,
      Offset((x1 + x2) / 2, y - 9),
      size: AppType.drawingDim,
      color: ink,
      plate: true,
    );
  }

  void _vDim(Canvas c, double y1, double y2, double x, String label) {
    final p = Paint()
      ..color = ink
      ..strokeWidth = Strokes.dimension;
    const tick = Sizes.dimTick;
    c
      ..drawLine(Offset(x, y1), Offset(x, y2), p)
      ..drawLine(Offset(x - tick, y1), Offset(x + tick, y1), p)
      ..drawLine(Offset(x - tick, y2), Offset(x + tick, y2), p)
      ..save()
      ..translate(x - 9, (y1 + y2) / 2)
      ..rotate(-1.5707963);
    _text(
      c,
      label,
      Offset.zero,
      size: AppType.drawingDim,
      color: ink,
      plate: true,
    );
    c.restore();
  }

  void _text(
    Canvas c,
    String s,
    Offset center, {
    required double size,
    required Color color,
    double? maxW,
    bool plate = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(fontSize: size, color: color),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '.',
    )..layout(maxWidth: maxW ?? double.infinity);
    final o = center - Offset(tp.width / 2, tp.height / 2);
    if (plate) {
      c.drawRect(
        Rect.fromLTWH(o.dx - 2, o.dy, tp.width + 4, tp.height),
        Paint()..color = paper.withValues(alpha: 0.9),
      );
    }
    tp.paint(c, o);
  }

  @override
  bool shouldRepaint(covariant ElevationPainter old) =>
      old.plan != plan || old.ink != ink || old.paper != paper;
}
