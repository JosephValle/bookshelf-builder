import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/cut_sheet.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_arrow.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_dimension.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_label.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark_kind.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_shape.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_tone.dart';
import 'package:bookshelf_builder/features/planner/domain/models/fasteners.dart';
import 'package:bookshelf_builder/features/planner/domain/models/layout_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/fastener_counter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/parts_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/piece_ids.dart';

/// Draws the rough 2D pictures for the assembly guide, in the style of flat
/// pack furniture instructions: which piece goes onto which, which way it
/// moves, and where the screws go.
///
/// Every picture is drawn to scale, with one scale for the whole picture, so
/// a length on the page is proportional to the real length. Only a few things
/// are not: the piece id tags, the screw and nail symbols, arrows, and views
/// that are cut off (a long panel or a tall unit) say so in their caption.
/// Piece ids, measurements and fastener distances always match the cut list
/// and the guide.
class AssemblyDiagramBuilder {
  /// Creates a builder.
  const AssemblyDiagramBuilder({
    this.formatter = const InchesFormatter(),
    this.counter = const FastenerCounter(),
  });

  /// Inch formatting for the measurement lines.
  final InchesFormatter formatter;

  /// Fastener counts for the hardware strip.
  final FastenerCounter counter;

  String _f(double v) => formatter.format(v);

  DiagramPoint _p(double x, double y) => DiagramPoint(x, y);

  DiagramMark _screw(double x, double y) => DiagramMark(_p(x, y));

  DiagramDimension _dim(double x1, double y1, double x2, double y2, String t) =>
      DiagramDimension(_p(x1, y1), _p(x2, y2), t);

  DiagramArrow _arrow(double x1, double y1, double x2, double y2) =>
      DiagramArrow(_p(x1, y1), _p(x2, y2));

  /// A small labelled tag used to name a piece that is too thin to hold text.
  DiagramShape _chip(
    double x,
    double y,
    String text, {
    DiagramTone tone = DiagramTone.panel,
  }) => DiagramShape.rect(x, y, 22, 12, label: text, tone: tone);

  /// Screws and glue for a joint.
  List<DiagramPiece> _hw(int screws, String screwName) => [
    DiagramPiece('', screws, screwName),
    const DiagramPiece('', 0, 'wood glue'),
  ];

  /// Entries for the pieces strip: one per piece id.
  List<DiagramPiece> _use(List<(String id, String name)> pieces) => [
    for (final (id, name) in pieces) DiagramPiece(id, 1, name),
  ];

  int _perJoint(Plan plan) => Fasteners.screwsPerJoint(plan.depthPanel);

  // ---------------------------------------------------------------------
  // French cleat

  /// The wall half and the unit half of the French cleat, apart and hooked.
  AssemblyDiagram cleatPair(Plan plan) {
    final ids = PieceIds(plan);
    final wall = ids.cleat(0, wall: true);
    final unit = ids.cleat(0, wall: false);
    // Real size: each strip is anchorCleatW wide and one panel thick, with the
    // 45 degree bevel cut across its whole thickness.
    const u = 16.0;
    const tk = Limits.t * u;
    const w = Limits.anchorCleatW * u;
    DiagramShape wallPiece(double x, double y) => DiagramShape([
      _p(x, y + tk),
      _p(x + tk, y),
      _p(x + tk, y + w),
      _p(x, y + w),
    ], tone: DiagramTone.cleat);
    DiagramShape unitPiece(double x, double y) => DiagramShape([
      _p(x, y),
      _p(x + tk, y),
      _p(x + tk, y + w - tk),
      _p(x, y + w),
    ]);
    // Hooked, the unit strip sits one width minus one thickness above the
    // wall strip so the two bevels meet.
    const hookedWall = 14 + w - tk;
    return AssemblyDiagram(
      caption:
          'Side view of the two halves, drawn to scale. Left: the wall piece '
          '($wall) and the unit piece ($unit) as cut, each ${_f(Limits.t)} '
          'thick and ${_f(Limits.anchorCleatW)} wide with a 45 degree bevel. '
          'Right: hooked together. The sloped edges slide together and the '
          'weight pulls them tight.',
      width: 250,
      height: 128,
      shapes: [
        wallPiece(20, 50),
        unitPiece(90, 14),
        wallPiece(170, hookedWall),
        unitPiece(170, 14),
      ],
      arrows: [_arrow(170 + tk / 2, 2, 170 + tk / 2, 12)],
      labels: [
        DiagramLabel(_p(20 + tk / 2, 50 + w + 8), wall),
        DiagramLabel(_p(90 + tk / 2, 14 + w + 8), unit),
      ],
      dimensions: [
        _dim(20 + tk + 8, 50, 20 + tk + 8, 50 + w, _f(Limits.anchorCleatW)),
      ],
      pieces: _use([(wall, 'wall French cleat'), (unit, 'unit French cleat')]),
    );
  }

  // ---------------------------------------------------------------------
  // Columns

  /// Diagram units per inch for the front view of a column: the tall panels
  /// fit 138 units and the column's width fits 96.
  double _columnScale(Plan plan, ColumnPlan c) =>
      math.min(138 / plan.sideH, 96 / (c.clearW + 2 * Limits.t));

  /// Distance from the bottom end of a column panel to the underside of the
  /// [k]th shelf (one based).
  double shelfPos(Plan plan, {required bool left, required int k}) {
    final c = left ? plan.leftCol : plan.rightCol;
    return k * c.clearH + (k - 1) * Limits.t;
  }

  /// A column panel with every shelf position marked on it.
  AssemblyDiagram columnMarks(Plan plan, {required bool left}) {
    final ids = PieceIds(plan);
    final c = left ? plan.leftCol : plan.rightCol;
    final outer = ids.id('Outer column panel', left ? 0 : 1);
    final inner = ids.id('Inner column panel', left ? 0 : 1);
    // Lying flat, each panel is sideH long and as wide as the unit is deep.
    final u = math.min(138 / plan.sideH, 55 / plan.depthPanel);
    final w = plan.depthPanel * u;
    const x0 = 50.0;
    const top = 14.0;
    final bottom = top + plan.sideH * u;
    double yAt(double pos) => bottom - pos * u;
    return AssemblyDiagram(
      caption:
          'Drawn to scale. Lay the outer panel ($outer) and the inner panel '
          '($inner) side by side and clamp them. Measure up from the bottom '
          'end and draw each shelf line across both. Each line is the '
          'underside of a shelf.',
      width: 190,
      height: bottom + 8,
      shapes: [
        DiagramShape.rect(x0, top, w, plan.sideH * u),
        DiagramShape.rect(x0 + w, top, w, plan.sideH * u),
        for (var k = 1; k <= c.shelves; k++)
          DiagramShape.rect(
            x0 - 4,
            yAt(shelfPos(plan, left: left, k: k)) - 0.75,
            2 * w + 8,
            1.5,
            tone: DiagramTone.cleat,
          ),
      ],
      labels: [
        DiagramLabel(_p(x0 + w / 2, top - 7), outer),
        DiagramLabel(_p(x0 + 1.5 * w, top - 7), inner),
      ],
      dimensions: [
        if (c.shelves >= 1)
          _dim(
            18,
            bottom,
            18,
            yAt(shelfPos(plan, left: left, k: 1)),
            _f(c.clearH),
          ),
        if (c.shelves >= 2)
          _dim(
            18,
            yAt(shelfPos(plan, left: left, k: 1)),
            18,
            yAt(shelfPos(plan, left: left, k: 2)),
            _f(c.clearH + Limits.t),
          ),
      ],
      pieces: _use([
        (outer, 'outer column panel'),
        (inner, 'inner column panel'),
      ]),
    );
  }

  /// The outer panel with shelf [k] (zero based) being attached.
  AssemblyDiagram columnShelf(Plan plan, {required bool left, required int k}) {
    final ids = PieceIds(plan);
    final c = left ? plan.leftCol : plan.rightCol;
    final shelfName = left ? 'Left column shelf' : 'Right column shelf';
    final outer = ids.id('Outer column panel', left ? 0 : 1);
    final cur = ids.id(shelfName, k);
    final u = _columnScale(plan, c);
    final tk = Limits.t * u;
    const x0 = 40.0;
    const top = 14.0;
    final bottom = top + plan.sideH * u;
    double yAt(double pos) => bottom - pos * u;
    final xr = x0 + tk + c.clearW * u;
    final y = yAt(shelfPos(plan, left: left, k: k + 1));
    return AssemblyDiagram(
      caption:
          'Front view, drawn to scale. Stand shelf $cur on its line on the '
          'outer panel ($outer), ${_f(shelfPos(plan, left: left, k: k + 1))} '
          'up from the bottom end to the underside of the shelf. Shelves '
          'already in place are shown pale.',
      width: xr + 44,
      height: bottom + 8,
      shapes: [
        DiagramShape.rect(x0, top, tk, plan.sideH * u),
        for (var i = 0; i < c.shelves; i++)
          if (i != k)
            DiagramShape.rect(
              x0 + tk,
              yAt(shelfPos(plan, left: left, k: i + 1)) - tk,
              c.clearW * u,
              tk,
              tone: DiagramTone.ghost,
            ),
        DiagramShape.rect(x0 + tk, y - tk, c.clearW * u, tk),
      ],
      labels: [
        DiagramLabel(_p(x0 + tk / 2, top - 7), outer),
        for (var i = 0; i < c.shelves; i++)
          if (i <= k)
            DiagramLabel(
              _p(
                x0 + tk + c.clearW * u / 2,
                yAt(shelfPos(plan, left: left, k: i + 1)) - tk - 5,
              ),
              ids.id(shelfName, i),
            ),
      ],
      arrows: [_arrow(xr + 38, y - tk / 2, xr + 4, y - tk / 2)],
      marks: [_screw(x0 + tk / 2, y - tk / 2)],
      dimensions: [
        _dim(8, bottom, 8, y, _f(shelfPos(plan, left: left, k: k + 1))),
      ],
      pieces: [
        ..._use([(outer, 'outer column panel'), (cur, 'shelf')]),
        ..._hw(_perJoint(plan), Fasteners.boxScrew),
      ],
    );
  }

  /// Where the screws go through a panel face into the end of a piece that
  /// meets it, for example a shelf end against a column panel.
  AssemblyDiagram shelfScrews(
    Plan plan, {
    required String panelId,
    required String bandId,
    required String bandName,
  }) {
    final d = plan.depthPanel;
    final s = 200 / d;
    final n = _perJoint(plan);
    final first = 10 + s * Fasteners.edgeInset;
    final last = 10 + s * (d - Fasteners.edgeInset);
    // The band is one panel thick; the panel is cut off above and below.
    final band = Limits.t * s;
    final bandY = 45 - band / 2;
    return AssemblyDiagram(
      caption:
          'Screw placement, drawn to scale across the panel (the panel is cut '
          'off above and below). Looking at the outside face of $panelId. '
          'The band is where $bandName $bandId meets it from behind. Drive '
          '$n screws through $panelId into the end of $bandId: '
          '${_f(Fasteners.edgeInset)} in from the front edge, '
          '${_f(Fasteners.edgeInset)} in from the back edge'
          '${n == 3 ? ', and one in the middle' : ''}. They sit in the middle '
          'of its thickness. Drill pilot holes first.',
      width: 246,
      height: 116,
      shapes: [
        DiagramShape.rect(10, 10, 200, 90, tone: DiagramTone.ghost),
        _chip(12, 12, panelId),
        _chip(38, 12, bandId, tone: DiagramTone.cleat),
        DiagramShape.rect(10, bandY, 200, band, tone: DiagramTone.cleat),
      ],
      marks: [
        for (var k = 0; k < n; k++)
          _screw(first + (last - first) * k / (n - 1), 45),
      ],
      dimensions: [
        _dim(10, 108, first, 108, _f(Fasteners.edgeInset)),
        _dim(last, 108, 210, 108, _f(Fasteners.edgeInset)),
        _dim(222, bandY + band, 222, 45, _f(Limits.t / 2)),
      ],
    );
  }

  /// A divider standing in an opening of a column.
  AssemblyDiagram columnDivider(
    Plan plan, {
    required bool left,
    required int opening,
    required int index,
  }) {
    final ids = PieceIds(plan);
    final c = left ? plan.leftCol : plan.rightCol;
    final divName = left ? 'Left column divider' : 'Right column divider';
    final shelfName = left ? 'Left column shelf' : 'Right column shelf';
    final outer = ids.id('Outer column panel', left ? 0 : 1);
    final inner = ids.id('Inner column panel', left ? 0 : 1);
    final cur = ids.id(divName, opening * c.dividers + index);
    final below = opening == 0
        ? 'bottom panel'
        : ids.id(shelfName, opening - 1);
    final above = opening == c.shelves
        ? 'top panel'
        : ids.id(shelfName, opening);
    final u = math.min(150 / c.clearW, 80 / c.clearH);
    final tk = Limits.t * u;
    final cw = c.clearW * u;
    final ch = c.clearH * u;
    const xa = 34.0;
    const ya = 14.0;
    final xr = xa + tk + cw;
    final yLow = ya + tk + ch;
    double x(int m) => xa + tk + (m * c.bayW + (m - 1) * Limits.t) * u;
    final m = index + 1;
    final dist = m * c.bayW + (m - 1) * Limits.t;
    final dimY = yLow + tk + 24;
    return AssemblyDiagram(
      caption:
          'Front view of one opening, drawn to scale. Stand divider $cur '
          'between $below (below) and $above (above), ${_f(dist)} from the '
          'face of the outer panel ($outer). Dividers already in place are '
          'shown pale.',
      width: xr + tk + 34,
      height: dimY + 8,
      shapes: [
        DiagramShape.rect(xa, ya, tk, ch + 2 * tk, tone: DiagramTone.ghost),
        DiagramShape.rect(xr, ya, tk, ch + 2 * tk, tone: DiagramTone.ghost),
        DiagramShape.rect(xa + tk, ya, cw, tk, tone: DiagramTone.ghost),
        DiagramShape.rect(xa + tk, yLow, cw, tk, tone: DiagramTone.ghost),
        for (var i = 1; i < m; i++)
          DiagramShape.rect(x(i), ya + tk, tk, ch, tone: DiagramTone.ghost),
        DiagramShape.rect(x(m), ya + tk, tk, ch),
      ],
      labels: [
        DiagramLabel(_p(xa - 12, ya + tk + ch / 2), outer),
        DiagramLabel(_p(xr + tk + 12, ya + tk + ch / 2), inner),
        DiagramLabel(_p(xa + tk + cw / 2, ya - 6), above),
        DiagramLabel(_p(xa + tk + cw / 2, yLow + tk + 7), below),
        for (var i = 1; i <= m; i++)
          DiagramLabel(
            _p(x(i) + tk + 8, ya + tk + ch / 2),
            ids.id(divName, opening * c.dividers + i - 1),
          ),
      ],
      marks: [
        _screw(x(m) + tk / 2, ya + tk / 2),
        _screw(x(m) + tk / 2, yLow + tk / 2),
      ],
      dimensions: [_dim(xa + tk, dimY, x(m), dimY, _f(dist))],
      pieces: [
        ..._use([(cur, 'divider')]),
        ..._hw(2 * _perJoint(plan), Fasteners.boxScrew),
      ],
    );
  }

  /// The inner panel going onto the shelf ends.
  AssemblyDiagram columnInner(Plan plan, {required bool left}) {
    final ids = PieceIds(plan);
    final c = left ? plan.leftCol : plan.rightCol;
    final shelfName = left ? 'Left column shelf' : 'Right column shelf';
    final outer = ids.id('Outer column panel', left ? 0 : 1);
    final inner = ids.id('Inner column panel', left ? 0 : 1);
    final u = _columnScale(plan, c);
    final tk = Limits.t * u;
    const x0 = 40.0;
    const top = 14.0;
    final bottom = top + plan.sideH * u;
    double yAt(double pos) => bottom - pos * u;
    final xi = x0 + tk + c.clearW * u;
    return AssemblyDiagram(
      caption:
          'Front view, drawn to scale. Lay the inner panel ($inner) on the '
          'free ends of the shelves, with its bottom end level with $outer '
          'and its shelf lines over the shelf ends. Then screw through it '
          'into every shelf.',
      width: xi + tk + 44,
      height: bottom + 8,
      shapes: [
        DiagramShape.rect(x0, top, tk, plan.sideH * u, tone: DiagramTone.ghost),
        for (var i = 0; i < c.shelves; i++)
          DiagramShape.rect(
            x0 + tk,
            yAt(shelfPos(plan, left: left, k: i + 1)) - tk,
            c.clearW * u,
            tk,
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(xi, top, tk, plan.sideH * u),
      ],
      labels: [
        DiagramLabel(_p(x0 + tk / 2, top - 7), outer),
        DiagramLabel(_p(xi + tk / 2, top - 7), inner),
        for (var i = 0; i < c.shelves; i++)
          DiagramLabel(
            _p(
              x0 + tk + c.clearW * u / 2,
              yAt(shelfPos(plan, left: left, k: i + 1)) - tk - 5,
            ),
            ids.id(shelfName, i),
          ),
      ],
      arrows: [
        _arrow(
          xi + tk + 38,
          top + plan.sideH * u / 2,
          xi + tk + 4,
          top + plan.sideH * u / 2,
        ),
      ],
      marks: [
        for (var i = 0; i < c.shelves; i++)
          _screw(
            xi + tk / 2,
            yAt(shelfPos(plan, left: left, k: i + 1)) - tk / 2,
          ),
      ],
      pieces: [
        ..._use([(inner, 'inner column panel')]),
        ..._hw(c.shelves * _perJoint(plan), Fasteners.boxScrew),
      ],
    );
  }

  /// A rectangle with both diagonals, for the "is it square" check.
  AssemblyDiagram squareCheck(
    Plan plan, {
    required double w,
    required double h,
    required String what,
  }) {
    final diag = math.sqrt(w * w + h * h);
    final u = math.min(150 / w, 100 / h);
    final rw = w * u;
    final rh = h * u;
    return AssemblyDiagram(
      caption:
          'Check that $what is square. Measure both diagonals. Each should '
          'be about ${_f(diag)}, and the two must match within 1/16". If one '
          'is longer, push the ends of that diagonal together with a clamp '
          'until they match.',
      width: 190,
      height: 130,
      shapes: [
        DiagramShape.rect(20, 10, rw, rh, tone: DiagramTone.ghost),
        DiagramShape([
          _p(20, 10),
          _p(23, 10),
          _p(20 + rw, 10 + rh),
          _p(17 + rw, 10 + rh),
        ], tone: DiagramTone.cleat),
        DiagramShape([
          _p(20 + rw, 10),
          _p(20 + rw - 3, 10),
          _p(20, 10 + rh),
          _p(23, 10 + rh),
        ], tone: DiagramTone.cleat),
      ],
      dimensions: [
        _dim(20, 10 + rh + 8, 20 + rw, 10 + rh + 8, _f(w)),
        _dim(20 + rw + 10, 10, 20 + rw + 10, 10 + rh, _f(h)),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Bars

  String _longName(bool top) => top ? 'Top panel' : 'Bottom panel';
  String _shortName(bool top) => top ? 'Head panel' : 'Sill panel';
  String _divName(bool top) => top ? 'Top bar divider' : 'Bottom bar divider';

  /// Distance from the left end of the long panel to the left face of divider
  /// [m] (one based).
  double dividerPos(Plan plan, {required bool top, required int m}) {
    final b = top ? plan.topBar : plan.bottomBar;
    return plan.inputs.left + m * b.bayW + (m - 1) * Limits.t;
  }

  double _sx(Plan plan) => 230 / plan.ringW;

  /// The long panel of a bar with the divider positions marked.
  AssemblyDiagram barMarks(Plan plan, {required bool top}) {
    final ids = PieceIds(plan);
    final b = top ? plan.topBar : plan.bottomBar;
    final long = ids.id(_longName(top));
    final sx = _sx(plan);
    double x(double inches) => 10 + inches * sx;
    final bot = 10 + plan.depthPanel * sx;
    return AssemblyDiagram(
      caption:
          'Drawn to scale. Rest ${top ? 'the top' : 'the bottom'} panel '
          '($long) flat on blocks with its inside face up and the front edge '
          'toward you. The shaded part is the bar; the panel sticks out '
          '${_f(plan.inputs.left)} on the left and ${_f(plan.inputs.right)} '
          'on the right where the columns will go. Draw a line for each '
          'divider, measured from the left end of the panel. Each line is '
          'the left face of a divider.',
      width: 260,
      height: bot + 28,
      shapes: [
        DiagramShape.rect(10, 10, 230, bot - 10, tone: DiagramTone.ghost),
        DiagramShape.rect(
          x(plan.inputs.left),
          10,
          plan.inputs.openW * sx,
          bot - 10,
          tone: DiagramTone.back,
        ),
        for (var m = 1; m <= b.dividers; m++)
          DiagramShape.rect(
            x(dividerPos(plan, top: top, m: m)),
            10,
            Limits.t * sx,
            bot - 10,
            tone: DiagramTone.cleat,
          ),
        _chip(12, bot + 4, long),
      ],
      dimensions: [
        if (b.dividers >= 1)
          _dim(
            10,
            bot + 20,
            x(dividerPos(plan, top: top, m: 1)),
            bot + 20,
            _f(dividerPos(plan, top: top, m: 1)),
          ),
        if (b.dividers >= 2)
          _dim(
            x(dividerPos(plan, top: top, m: 1)),
            bot + 12,
            x(dividerPos(plan, top: top, m: 2)),
            bot + 12,
            _f(
              dividerPos(plan, top: top, m: 2) -
                  dividerPos(plan, top: top, m: 1),
            ),
          ),
      ],
      pieces: _use([(long, 'long panel')]),
    );
  }

  /// One divider with the back notch for the anchor cleat.
  AssemblyDiagram barNotch(Plan plan, {required bool top}) {
    final ids = PieceIds(plan);
    final b = top ? plan.topBar : plan.bottomBar;
    final div = ids.id(_divName(top));
    final u = math.min(140 / plan.depthPanel, 70 / b.dividerLength);
    const x0 = 34.0;
    const y0 = 14.0;
    final w = plan.depthPanel * u;
    final h = b.dividerLength * u;
    final nh = math.min(Limits.anchorCleatW, b.dividerLength) * u;
    final nw = Limits.t * u;
    return AssemblyDiagram(
      caption:
          'Side view of a divider, drawn to scale. The back is on the left. '
          'Cut a notch ${_f(Limits.t)} deep and ${_f(Limits.anchorCleatW)} '
          'tall out of the back ${top ? 'top' : 'bottom'} corner of every '
          'divider (each ${_f(b.dividerLength)} long) so the anchor cleat '
          'sits flush.',
      width: x0 + w + 10,
      height: y0 + h + 12,
      shapes: [
        DiagramShape(
          top
              ? [
                  _p(x0 + nw, y0),
                  _p(x0 + w, y0),
                  _p(x0 + w, y0 + h),
                  _p(x0, y0 + h),
                  _p(x0, y0 + nh),
                  _p(x0 + nw, y0 + nh),
                ]
              : [
                  _p(x0, y0),
                  _p(x0 + w, y0),
                  _p(x0 + w, y0 + h - nh),
                  _p(x0 + nw, y0 + h - nh),
                  _p(x0 + nw, y0 + h),
                  _p(x0, y0 + h),
                ],
          label: div,
        ),
      ],
      dimensions: [
        _dim(x0, 8, x0 + nw, 8, _f(Limits.t)),
        if (top)
          _dim(8, y0, 8, y0 + nh, _f(Limits.anchorCleatW))
        else
          _dim(8, y0 + h - nh, 8, y0 + h, _f(Limits.anchorCleatW)),
      ],
      pieces: _use([(div, 'divider')]),
    );
  }

  /// A divider being screwed to the long panel.
  AssemblyDiagram barDivider(Plan plan, {required bool top, required int k}) {
    final ids = PieceIds(plan);
    final long = ids.id(_longName(top));
    final sx = _sx(plan);
    final n = _perJoint(plan);
    final bot = 10 + plan.depthPanel * sx;
    final firstY = 10 + sx * Fasteners.edgeInset;
    final lastY = bot - sx * Fasteners.edgeInset;
    final half = Limits.t * sx / 2;
    double x(int m) =>
        10 + (dividerPos(plan, top: top, m: m) + Limits.t / 2) * sx;
    final cur = ids.id(_divName(top), k);
    final m = k + 1;
    return AssemblyDiagram(
      caption:
          'Looking at the outside face of the long panel ($long), drawn to '
          'scale. Stand divider $cur on its end on line $m, '
          '${_f(dividerPos(plan, top: top, m: m))} from the left end, with '
          'its front edge level with the front edge of the panel. From '
          'underneath, drive $n screws up through the panel into it, '
          '${_f(Fasteners.edgeInset)} in from the front and back edges. '
          'Dividers already fixed are shown pale.',
      width: 260,
      height: bot + 34,
      shapes: [
        DiagramShape.rect(10, 10, 230, bot - 10, tone: DiagramTone.ghost),
        _chip(12, bot + 4, long),
        for (var i = 1; i < m; i++)
          DiagramShape.rect(
            x(i) - half,
            10,
            half * 2,
            bot - 10,
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(
          x(m) - half,
          10,
          half * 2,
          bot - 10,
          tone: DiagramTone.cleat,
        ),
      ],
      labels: [
        for (var i = 1; i <= m; i++)
          DiagramLabel(_p(x(i), bot + 10), ids.id(_divName(top), i - 1)),
      ],
      marks: [
        for (var j = 0; j < n; j++)
          _screw(x(m), firstY + (lastY - firstY) * j / (n - 1)),
      ],
      dimensions: [
        _dim(250, 10, 250, firstY, _f(Fasteners.edgeInset)),
        _dim(250, lastY, 250, bot, _f(Fasteners.edgeInset)),
        _dim(
          10,
          bot + 26,
          x(m) - half,
          bot + 26,
          _f(dividerPos(plan, top: top, m: m)),
        ),
      ],
      pieces: [
        ..._use([(long, 'long panel'), (cur, 'divider')]),
        ..._hw(n, Fasteners.boxScrew),
      ],
    );
  }

  /// The short skin panel going onto every divider.
  AssemblyDiagram barSkin(Plan plan, {required bool top}) {
    final ids = PieceIds(plan);
    final b = top ? plan.topBar : plan.bottomBar;
    final short = ids.id(_shortName(top));
    final long = ids.id(_longName(top));
    final sx = _sx(plan);
    final n = _perJoint(plan);
    final bot = 10 + plan.depthPanel * sx;
    final firstY = 10 + sx * Fasteners.edgeInset;
    final lastY = bot - sx * Fasteners.edgeInset;
    final x0 = 10 + plan.inputs.left * sx;
    double x(int m) =>
        10 + (dividerPos(plan, top: top, m: m) + Limits.t / 2) * sx;
    return AssemblyDiagram(
      caption:
          'Drawn to scale. Lay the '
          '${top ? 'head' : 'sill'} panel ($short) on top of the dividers, level '
          'with the ends of the bar and with the front edges. It is '
          '${_f(plan.inputs.openW)} long, so it stops ${_f(plan.inputs.left)} '
          'short of the left end of $long. Drive $n screws down through it '
          'into each divider, ${_f(Fasteners.edgeInset)} in from the front '
          'and back edges.',
      width: 260,
      height: bot + 20,
      shapes: [
        DiagramShape.rect(x0, 10, plan.inputs.openW * sx, bot - 10),
        _chip(12, bot + 4, short),
        for (var m = 1; m <= b.dividers; m++)
          DiagramShape.rect(
            x(m) - Limits.t * sx / 2,
            10,
            Limits.t * sx,
            bot - 10,
            tone: DiagramTone.cleat,
          ),
      ],
      marks: [
        for (var m = 1; m <= b.dividers; m++)
          for (var j = 0; j < n; j++)
            _screw(x(m), firstY + (lastY - firstY) * j / (n - 1)),
      ],
      dimensions: [
        _dim(250, 10, 250, firstY, _f(Fasteners.edgeInset)),
        _dim(250, lastY, 250, bot, _f(Fasteners.edgeInset)),
      ],
      pieces: [
        ..._use([(short, '${top ? 'head' : 'sill'} panel')]),
        ..._hw(b.dividers * n, Fasteners.boxScrew),
      ],
    );
  }

  /// Side cut of a bar showing the notched divider, anchor cleat and back.
  AssemblyDiagram barCleat(Plan plan, {required bool top}) {
    final ids = PieceIds(plan);
    final b = top ? plan.topBar : plan.bottomBar;
    final long = ids.id(_longName(top));
    final short = ids.id(_shortName(top));
    final div = ids.id(_divName(top));
    final cleatName = top
        ? PartsBuilder.topCleatName
        : PartsBuilder.bottomCleatName;
    final cleat = ids.id(cleatName);
    final backName = top ? 'Back panel, top bar' : 'Back panel, bottom bar';
    final back = ids.id(backName);
    final skinTop = top ? long : short;
    final skinBottom = top ? short : long;
    final u = math.min(
      110 / plan.depthPanel,
      72 / (b.dividerLength + 2 * Limits.t),
    );
    final tk = Limits.t * u;
    final bk = Limits.backT * u;
    final dk = b.dividerLength * u;
    final cw = math.min(Limits.anchorCleatW, b.dividerLength) * u;
    const x0 = 30.0;
    const y0 = 14.0;
    final xb = x0 + bk;
    final w = plan.depthPanel * u;
    final yDiv = y0 + tk;
    final yBot = yDiv + dk;
    return AssemblyDiagram(
      caption:
          'Side cut through the bar, drawn to scale. The back is on the '
          'left. Glue the anchor cleat ($cleat) into the notches, tight '
          'against the ${top ? 'top' : 'bottom'} skin, and screw it to every '
          'divider ($div). This solid piece is where the wall anchors bite.',
      width: xb + w + 10,
      height: yBot + tk + 16,
      shapes: [
        DiagramShape.rect(x0, y0, bk, dk + 2 * tk, tone: DiagramTone.back),
        DiagramShape.rect(xb, y0, w, tk),
        DiagramShape.rect(xb, yBot, w, tk),
        DiagramShape(
          top
              ? [
                  _p(xb + tk, yDiv),
                  _p(xb + w, yDiv),
                  _p(xb + w, yBot),
                  _p(xb, yBot),
                  _p(xb, yDiv + cw),
                  _p(xb + tk, yDiv + cw),
                ]
              : [
                  _p(xb, yDiv),
                  _p(xb + w, yDiv),
                  _p(xb + w, yBot),
                  _p(xb + tk, yBot),
                  _p(xb + tk, yBot - cw),
                  _p(xb, yBot - cw),
                ],
          label: div,
        ),
        DiagramShape.rect(
          xb,
          top ? yDiv : yBot - cw,
          tk,
          cw,
          tone: DiagramTone.cleat,
        ),
      ],
      labels: [
        DiagramLabel(_p(x0 + bk / 2, y0 - 7), back),
        DiagramLabel(_p(xb + w * 0.6, y0 - 7), skinTop),
        DiagramLabel(_p(xb + w * 0.6, yBot + tk + 7), skinBottom),
        DiagramLabel(_p(x0 - 8, top ? yDiv + cw / 2 : yBot - cw / 2), cleat),
      ],
      pieces: [
        ..._use([(cleat, 'anchor cleat')]),
        ..._hw(
          math.max(1, (top ? plan.topBar : plan.bottomBar).dividers) * 2,
          Fasteners.boxScrew,
        ),
      ],
    );
  }

  /// A middle shelf in a two tier bar.
  AssemblyDiagram barShelf(Plan plan, {required bool top, required int k}) {
    final ids = PieceIds(plan);
    final b = top ? plan.topBar : plan.bottomBar;
    final shelfName = top ? 'Top bar shelf' : 'Bottom bar shelf';
    final cur = ids.id(shelfName, k);
    final n = b.dividers + 1;
    final total = n * b.bayW + b.dividers * Limits.t;
    final u = math.min(200 / total, 64 / (b.dividerLength + 2 * Limits.t));
    final tk = Limits.t * u;
    final bw = b.bayW * u;
    final dk = b.dividerLength * u;
    const x0 = 10.0;
    const y0 = 14.0;
    final bx = x0 + k * (bw + tk);
    final mid = y0 + tk + dk / 2;
    return AssemblyDiagram(
      caption:
          'Front view of the bar, drawn to scale. Fit shelf $cur in bay '
          '${k + 1}, level with the middle of the bar, and screw through '
          'each divider into its ends.',
      width: x0 + total * u + 10,
      height: y0 + dk + 2 * tk + 14,
      shapes: [
        DiagramShape.rect(x0, y0, total * u, tk, tone: DiagramTone.ghost),
        DiagramShape.rect(
          x0,
          y0 + tk + dk,
          total * u,
          tk,
          tone: DiagramTone.ghost,
        ),
        for (var i = 1; i < n; i++)
          DiagramShape.rect(
            x0 + i * bw + (i - 1) * tk,
            y0 + tk,
            tk,
            dk,
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(bx, mid - tk / 2, bw, tk),
      ],
      labels: [DiagramLabel(_p(bx + bw / 2, mid + tk / 2 + 5), cur)],
      arrows: [_arrow(bx + bw / 2, y0 + tk + 2, bx + bw / 2, mid - tk / 2 - 2)],
      pieces: [
        ..._use([(cur, 'bar shelf')]),
        ..._hw(2 * _perJoint(plan), Fasteners.boxScrew),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Ring

  /// The four assemblies lying on their backs, showing which are placed.
  ///
  /// [stage] is 0 for the top bar unit alone, 1 with the left column, 2 with
  /// the right column and 3 with the bottom bar unit.
  AssemblyDiagram ringStage(Plan plan, {required int stage}) {
    DiagramTone tone(int s) =>
        stage == s ? DiagramTone.panel : DiagramTone.ghost;
    final i = plan.inputs;
    final u = math.min(236 / plan.ringW, 150 / plan.ringH);
    const y0 = 4.0;
    const colGap = 14.0;
    const barGap = 28.0;
    final colTop = y0 + i.top * u;
    final openH = i.openH * u;
    final bottomFinal = colTop + openH;
    final barY = bottomFinal + (stage == 3 ? barGap : 0);
    final ringW = plan.ringW * u;
    return AssemblyDiagram(
      caption:
          'Top view of the unit lying on its back on the floor, drawn to '
          'scale, top of the unit at the top of the picture. ${switch (stage) {
            0 => 'Lay the top bar unit down first.',
            1 => 'Slide the left column up against the top panel.',
            2 => 'Slide the right column up against the top panel.',
            _ => 'Slide the bottom bar unit up onto the column ends.',
          }}',
      width: ringW,
      height: y0 + plan.ringH * u + barGap + 4,
      shapes: [
        DiagramShape.rect(
          0,
          y0,
          ringW,
          i.top * u,
          label: 'Top bar unit',
          tone: tone(0),
        ),
        if (stage >= 1)
          DiagramShape.rect(
            0,
            stage == 1 ? colTop + colGap : colTop,
            i.left * u,
            openH,
            label: 'Left',
            tone: tone(1),
          ),
        if (stage >= 2)
          DiagramShape.rect(
            ringW - i.right * u,
            stage == 2 ? colTop + colGap : colTop,
            i.right * u,
            openH,
            label: 'Right',
            tone: tone(2),
          ),
        if (stage >= 1)
          DiagramShape.rect(
            i.left * u,
            colTop,
            i.openW * u,
            openH,
            label: 'window',
            tone: DiagramTone.ghost,
          ),
        if (stage >= 3)
          DiagramShape.rect(
            0,
            barY,
            ringW,
            i.bottom * u,
            label: 'Bottom bar unit',
            tone: tone(3),
          ),
      ],
      arrows: [
        if (stage == 1)
          _arrow(
            i.left * u / 2,
            colTop + colGap - 2,
            i.left * u / 2,
            colTop + 1,
          ),
        if (stage == 2)
          _arrow(
            ringW - i.right * u / 2,
            colTop + colGap - 2,
            ringW - i.right * u / 2,
            colTop + 1,
          ),
        if (stage == 3) _arrow(ringW / 2, barY - 2, ringW / 2, bottomFinal + 2),
      ],
    );
  }

  /// The long panel of a bar seen from outside, with the column panel ends
  /// behind it and their screws.
  AssemblyDiagram ringColumn(
    Plan plan, {
    required bool left,
    required bool top,
  }) {
    final ids = PieceIds(plan);
    final i = plan.inputs;
    final long = ids.id(_longName(top));
    final outer = ids.id('Outer column panel', left ? 0 : 1);
    final inner = ids.id('Inner column panel', left ? 0 : 1);
    final sx = _sx(plan);
    double x(double inches) => 10 + inches * sx;
    final n = _perJoint(plan);
    final bot = 10 + plan.depthPanel * sx;
    final firstY = 10 + sx * Fasteners.edgeInset;
    final lastY = bot - sx * Fasteners.edgeInset;
    final half = Limits.t * sx / 2;
    final xOuter = left ? Limits.t / 2 : plan.ringW - Limits.t / 2;
    final xInner = left
        ? i.left - Limits.t / 2
        : i.left + i.openW + Limits.t / 2;
    final innerFace = left
        ? i.left - Limits.t
        : plan.ringW - i.right + Limits.t;
    final other = [
      if (left) ...[
        x(i.left + i.openW + Limits.t / 2),
        x(plan.ringW - Limits.t / 2),
      ] else ...[
        x(Limits.t / 2),
        x(i.left - Limits.t / 2),
      ],
    ];
    return AssemblyDiagram(
      caption:
          'Looking at the outside face of the ${top ? 'top' : 'bottom'} '
          'panel ($long), drawn to scale. Stand the ${left ? 'left' : 'right'} column on it: '
          'the outer panel ($outer) level with the ${left ? 'left' : 'right'} '
          'end of the panel, and the inner panel ($inner) '
          '${_f(left ? i.left - Limits.t : i.right - Limits.t)} in from that end, on '
          'the bar side of the column. Both stand flush with the front '
          'edge. Drive $n screws through the panel into the end of each, '
          '${_f(Fasteners.edgeInset)} in from the front and back edges.',
      width: 260,
      height: bot + 34,
      shapes: [
        DiagramShape.rect(10, 10, 230, bot - 10, tone: DiagramTone.ghost),
        _chip(12, bot + 4, long),
        for (final ox in other)
          DiagramShape.rect(
            ox - half,
            10,
            half * 2,
            bot - 10,
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(
          x(xOuter) - half,
          10,
          half * 2,
          bot - 10,
          tone: DiagramTone.cleat,
        ),
        DiagramShape.rect(
          x(xInner) - half,
          10,
          half * 2,
          bot - 10,
          tone: DiagramTone.cleat,
        ),
        _chip(40, bot + 4, outer),
        _chip(68, bot + 4, inner),
      ],
      marks: [
        for (final cx in [x(xOuter), x(xInner)])
          for (var j = 0; j < n; j++)
            _screw(cx, firstY + (lastY - firstY) * j / (n - 1)),
      ],
      dimensions: [
        _dim(250, 10, 250, firstY, _f(Fasteners.edgeInset)),
        _dim(250, lastY, 250, bot, _f(Fasteners.edgeInset)),
        if (left)
          _dim(10, bot + 26, x(innerFace), bot + 26, _f(i.left - Limits.t))
        else
          _dim(x(innerFace), bot + 26, 240, bot + 26, _f(i.right - Limits.t)),
      ],
      pieces: [
        ..._use([(outer, 'outer column panel'), (inner, 'inner column panel')]),
        ..._hw(2 * n, Fasteners.boxScrew),
      ],
    );
  }

  /// An inner column panel screwed into the end of a bar's short skin.
  AssemblyDiagram barEnd(Plan plan, {required bool left, required bool top}) {
    final ids = PieceIds(plan);
    final inner = ids.id('Inner column panel', left ? 0 : 1);
    final short = ids.id(_shortName(top));
    final n = _perJoint(plan);
    return shelfScrews(
      plan,
      panelId: inner,
      bandId: short,
      bandName: 'the ${top ? 'head' : 'sill'} panel',
    ).withPieces([
      ..._use([
        (inner, 'inner column panel'),
        (short, '${top ? 'head' : 'sill'} panel'),
      ]),
      ..._hw(n, Fasteners.boxScrew),
    ]);
  }

  /// The toe kick fixed to blocking under the bottom panel.
  AssemblyDiagram toeKick(Plan plan) {
    final ids = PieceIds(plan);
    final kick = ids.id(PartsBuilder.toeKickName);
    final bottom = ids.id('Bottom panel');
    final u = math.min(120 / plan.depthPanel, 14.0);
    final tk = Limits.t * u;
    final w = plan.depthPanel * u;
    const x0 = 20.0;
    const y0 = 4.0;
    const unitH = 40.0;
    // The toe kick is set back 2" from the front; the blocks behind it are
    // scraps, so their 2" width is only a suggestion.
    const setBack = 2.0;
    const blockW = 2.0;
    final front = x0 + w;
    final kickX = front - (setBack + Limits.t) * u;
    final yUnder = y0 + unitH + tk;
    final kickH = plan.kick * u;
    final midY = yUnder + kickH / 2;
    return AssemblyDiagram(
      caption:
          'Side view, drawn to scale. The front is on the right. Glue blocks '
          'cut from offcuts under the bottom panel ($bottom), set back from '
          'the front, then screw the toe kick ($kick) to them about every '
          '${_f(Fasteners.toeKickSpacing)}. The toe kick stands '
          '${_f(plan.kick)} tall and is set back ${_f(setBack)} from the '
          'front. The unit above is cut off.',
      width: front + 44,
      height: yUnder + kickH + 18,
      shapes: [
        DiagramShape.rect(x0, y0, w, unitH, tone: DiagramTone.ghost),
        DiagramShape.rect(x0, y0 + unitH, w, tk),
        DiagramShape.rect(
          kickX - blockW * u,
          yUnder,
          blockW * u,
          kickH,
          tone: DiagramTone.cleat,
        ),
        DiagramShape.rect(kickX, yUnder, Limits.t * u, kickH),
        DiagramShape.rect(
          x0 - 10,
          yUnder + kickH,
          w + 20,
          3,
          tone: DiagramTone.wall,
        ),
      ],
      labels: [
        DiagramLabel(_p(x0 + w / 2, y0 + unitH - 6), bottom),
        DiagramLabel(_p(kickX + Limits.t * u / 2, yUnder + kickH + 10), kick),
      ],
      marks: [_screw(kickX + Limits.t * u / 2, midY)],
      arrows: [_arrow(front + 40, midY, kickX + Limits.t * u + 8, midY)],
      pieces: [
        ..._use([(kick, 'toe kick')]),
        ..._hw(counter.toeKickScrews(plan), Fasteners.boxScrew),
      ],
    );
  }

  static const List<String> _backNames = [
    'Back panel, left column',
    'Back panel, right column',
    'Back panel, top bar',
    'Back panel, bottom bar',
  ];

  /// The back of the unit; back panel number [current] (0 to 3) is being
  /// fitted and the earlier ones are shown pale.
  AssemblyDiagram backs(Plan plan, {required int current}) {
    final ids = PieceIds(plan);
    final i = plan.inputs;
    final u = math.min(240 / plan.ringW, 160 / plan.ringH);
    final ringW = plan.ringW * u;
    final ringH = plan.ringH * u;
    final rects = [
      (0.0, 0.0, i.left * u, ringH),
      (ringW - i.right * u, 0.0, i.right * u, ringH),
      (i.left * u, 0.0, i.openW * u, i.top * u),
      (i.left * u, ringH - i.bottom * u, i.openW * u, i.bottom * u),
    ];
    final id = ids.id(_backNames[current]);
    return AssemblyDiagram(
      caption:
          'Back view, drawn to scale. Lay back panel $id on the ${const ['left column', 'right column', 'top bar', 'bottom bar'][current]}, level with its outer edges. Backs already fixed are '
          'shown pale.',
      width: ringW,
      height: ringH,
      shapes: [
        for (var n = 0; n < 4; n++)
          if (n <= current)
            DiagramShape.rect(
              rects[n].$1,
              rects[n].$2,
              rects[n].$3,
              rects[n].$4,
              label: ids.id(_backNames[n]),
              tone: n == current ? DiagramTone.back : DiagramTone.ghost,
            ),
        DiagramShape.rect(
          i.left * u,
          i.top * u,
          i.openW * u,
          i.openH * u,
          label: 'window',
          tone: DiagramTone.ghost,
        ),
      ],
      pieces: [
        ..._use([(id, 'back panel')]),
        DiagramPiece(
          '',
          counter.backPanelBrads(plan, current),
          '1" brad nails',
        ),
        const DiagramPiece('', 0, 'wood glue'),
      ],
    );
  }

  /// A corner of a back panel showing where the brads go.
  AssemblyDiagram nails(Plan plan, {required String backId}) {
    const s = 12.0;
    const inset = Fasteners.nailInset * s;
    const gap = Fasteners.nailSpacing * s;
    // The dark band is the edge of a shelf or divider behind the back.
    const band = Limits.t * s;
    const bandY = 56.0;
    const bandMid = bandY + band / 2;
    return AssemblyDiagram(
      caption:
          'Nail placement on back panel $backId (a corner), drawn to scale. '
          'Brads go ${_f(Fasteners.nailInset)} in from every edge and no '
          'more than ${_f(Fasteners.nailSpacing)} apart. Also nail into '
          'every shelf and divider behind it (the dark band), at the same '
          'spacing.',
      width: 254,
      height: 122,
      shapes: [
        DiagramShape.rect(10, 10, 220, 100, tone: DiagramTone.back),
        DiagramShape.rect(10, bandY, 220, band, tone: DiagramTone.cleat),
        _chip(12, 94, backId),
      ],
      marks: [
        for (final x in [
          10 + inset,
          10 + inset + gap,
          10 + inset + 2 * gap,
        ]) ...[
          DiagramMark(_p(x, 10 + inset), kind: DiagramMarkKind.nail),
          DiagramMark(_p(x, bandMid), kind: DiagramMarkKind.nail),
        ],
        DiagramMark(_p(10 + inset, 90), kind: DiagramMarkKind.nail),
      ],
      dimensions: [
        _dim(242, 10, 242, 10 + inset, _f(Fasteners.nailInset)),
        _dim(10 + inset, 116, 10 + inset + gap, 116, _f(Fasteners.nailSpacing)),
      ],
    );
  }

  /// The back of the unit with the unit half of the cleat; piece [current]
  /// (0 to 3) is being fixed.
  AssemblyDiagram unitCleat(Plan plan, {required int current}) {
    final ids = PieceIds(plan);
    final i = plan.inputs;
    String sub(int n) => ids.cleat(n, wall: false);
    final left = current < 2;
    final u = math.min(240 / plan.ringW, 160 / plan.ringH);
    final ringW = plan.ringW * u;
    final ringH = plan.ringH * u;
    final lens = counter.cleatPieceLengths(plan);
    // One row near the top and one near the middle of each column.
    double rowY(int n) => ringH * (n.isEven ? 0.14 : 0.52);
    double pieceX(int n) => n < 2 ? 0 : ringW - lens[n] * u;
    return AssemblyDiagram(
      caption:
          'Back view, unit face down, drawn to scale. Fix piece '
          '${sub(current)} to the ${left ? 'left' : 'right'} column, '
          '${current.isEven ? 'near the top' : 'near the middle'}. '
          'Pieces already fixed are shown pale.',
      width: ringW,
      height: ringH,
      shapes: [
        DiagramShape.rect(0, 0, i.left * u, ringH, tone: DiagramTone.ghost),
        DiagramShape.rect(
          i.left * u,
          0,
          i.openW * u,
          i.top * u,
          tone: DiagramTone.ghost,
        ),
        DiagramShape.rect(
          i.left * u,
          ringH - i.bottom * u,
          i.openW * u,
          i.bottom * u,
          tone: DiagramTone.ghost,
        ),
        DiagramShape.rect(
          ringW - i.right * u,
          0,
          i.right * u,
          ringH,
          tone: DiagramTone.ghost,
        ),
        for (var n = 0; n <= current; n++)
          DiagramShape.rect(
            pieceX(n),
            rowY(n),
            lens[n] * u,
            Limits.anchorCleatW * u,
            label: sub(n),
            tone: n == current ? DiagramTone.cleat : DiagramTone.ghost,
          ),
      ],
      pieces: [
        ..._use([(sub(current), 'unit cleat piece')]),
        ..._hw(
          counter.pieceScrews(plan, current, wall: false),
          Fasteners.unitCleatScrew,
        ),
      ],
    );
  }

  /// The face of a cleat piece with its screws, for either half.
  AssemblyDiagram cleatScrews(
    Plan plan, {
    required bool wall,
    required int piece,
  }) {
    final ids = PieceIds(plan);
    final id = ids.cleat(piece, wall: wall);
    final len = counter.cleatPieceLengths(plan)[piece];
    // The strip is drawn to scale: its real length by its real width.
    final s = math.min(230 / len, 24.0);
    final len2 = len * s;
    final h = Limits.anchorCleatW * s;
    if (!wall) {
      final gaps = math.max(
        1,
        ((len - 2 * Fasteners.cleatEndInset) / Fasteners.screwSpacing).ceil(),
      );
      final first = 10 + s * Fasteners.cleatEndInset;
      final last = 10 + len2 - s * Fasteners.cleatEndInset;
      final xs = [
        for (var k = 0; k <= gaps; k++) first + (last - first) * k / gaps,
      ];
      return AssemblyDiagram(
        caption:
            'Screw placement, drawn to scale. The face of unit cleat piece '
            '$id, ${_f(len)} long, centered on a shelf. Put a screw '
            '${_f(Fasteners.cleatEndInset)} from each end and one at least '
            'every ${_f(Fasteners.screwSpacing)} between, along the middle '
            'of the strip, through the back panel into the shelf edge.',
        width: len2 + 32,
        height: 20 + h + 40,
        shapes: [
          DiagramShape.rect(
            10,
            20,
            len2,
            h,
            label: id,
            tone: DiagramTone.cleat,
          ),
        ],
        marks: [for (final x in xs) _screw(x, 20 + h / 2)],
        dimensions: [
          _dim(
            10,
            20 + h + 16,
            first,
            20 + h + 16,
            _f(Fasteners.cleatEndInset),
          ),
          _dim(
            last,
            20 + h + 16,
            10 + len2,
            20 + h + 16,
            _f(Fasteners.cleatEndInset),
          ),
          if (xs.length > 1)
            _dim(
              xs[0],
              20 + h + 28,
              xs[1],
              20 + h + 28,
              '${_f(Fasteners.screwSpacing)} or less',
            ),
        ],
      );
    }
    if (plan.inputs.concreteWall) {
      final gaps = math.max(
        1,
        ((len - 2 * Fasteners.concreteEndInset) / Fasteners.concreteSpacing)
            .ceil(),
      );
      final first = 10 + s * Fasteners.concreteEndInset;
      final last = 10 + len2 - s * Fasteners.concreteEndInset;
      final xs = [
        for (var k = 0; k <= gaps; k++) first + (last - first) * k / gaps,
      ];
      final inset = s * Fasteners.wallScrewEdgeInset;
      return AssemblyDiagram(
        caption:
            'Screw placement, drawn to scale. The face of wall cleat piece '
            '$id, ${_f(len)} long, on a concrete wall. Drive a pair of '
            'concrete screws ${_f(Fasteners.concreteEndInset)} from each '
            'end, and another pair at least every '
            '${_f(Fasteners.concreteSpacing)} between. In each pair, one '
            'screw is ${_f(Fasteners.wallScrewEdgeInset)} below the top edge '
            'and one ${_f(Fasteners.wallScrewEdgeInset)} above the bottom '
            'edge.',
        width: len2 + 42,
        height: 24 + h + 36,
        shapes: [
          DiagramShape.rect(
            10,
            24,
            len2,
            h,
            label: id,
            tone: DiagramTone.cleat,
          ),
        ],
        marks: [
          for (final x in xs) ...[
            _screw(x, 24 + inset),
            _screw(x, 24 + h - inset),
          ],
        ],
        dimensions: [
          _dim(
            10,
            24 + h + 16,
            first,
            24 + h + 16,
            _f(Fasteners.concreteEndInset),
          ),
          _dim(
            last,
            24 + h + 16,
            10 + len2,
            24 + h + 16,
            _f(Fasteners.concreteEndInset),
          ),
          if (xs.length > 1)
            _dim(
              xs[0],
              24 + h + 30,
              xs[1],
              24 + h + 30,
              '${_f(Fasteners.concreteSpacing)} or less',
            ),
          _dim(
            10 + len2 + 10,
            24,
            10 + len2 + 10,
            24 + inset,
            _f(Fasteners.wallScrewEdgeInset),
          ),
          _dim(
            10 + len2 + 10,
            24 + h - inset,
            10 + len2 + 10,
            24 + h,
            _f(Fasteners.wallScrewEdgeInset),
          ),
        ],
        pieces: [
          ..._use([(id, 'wall cleat piece')]),
          DiagramPiece(
            '',
            counter.pieceScrews(plan, piece, wall: true),
            Fasteners.concreteScrew,
          ),
        ],
      );
    }
    // A stud is a nominal 2x4 seen from the front: 1-1/2" wide. The studs a
    // piece crosses are spread evenly about its middle, one spacing apart.
    const studW = 1.5;
    final sp = plan.inputs.studSpacing;
    final n = math.max(1, (len / sp).ceil());
    final studs = [
      for (var j = 0; j < n; j++) len / 2 + (j - (n - 1) / 2) * sp,
    ];
    final inset = s * Fasteners.wallScrewEdgeInset;
    return AssemblyDiagram(
      caption:
          'Screw placement, drawn to scale. The face of wall cleat piece '
          '$id, ${_f(len)} long, over ${n == 1 ? 'a stud' : '$n studs'}. '
          'Drive two screws into every stud it crosses: one '
          '${_f(Fasteners.wallScrewEdgeInset)} below the top edge and one '
          '${_f(Fasteners.wallScrewEdgeInset)} above the bottom edge. Studs '
          'are usually ${_f(sp)} apart.',
      width: len2 + 42,
      height: 24 + h + 32,
      shapes: [
        for (final x in studs)
          DiagramShape.rect(
            10 + (x - studW / 2) * s,
            8,
            studW * s,
            h + 24,
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(10, 24, len2, h, label: id, tone: DiagramTone.cleat),
      ],
      marks: [
        for (final x in studs) ...[
          _screw(10 + x * s, 24 + inset),
          _screw(10 + x * s, 24 + h - inset),
        ],
      ],
      dimensions: [
        _dim(
          10 + len2 + 10,
          24,
          10 + len2 + 10,
          24 + inset,
          _f(Fasteners.wallScrewEdgeInset),
        ),
        _dim(
          10 + len2 + 10,
          24 + h - inset,
          10 + len2 + 10,
          24 + h,
          _f(Fasteners.wallScrewEdgeInset),
        ),
        if (n > 1)
          _dim(
            10 + studs[0] * s,
            24 + h + 14,
            10 + studs[1] * s,
            24 + h + 14,
            _f(sp),
          ),
      ],
      pieces: [
        ..._use([(id, 'wall cleat piece')]),
        DiagramPiece(
          '',
          counter.pieceScrews(plan, piece, wall: true),
          Fasteners.studScrew,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Cutting layout

  /// One plywood sheet drawn to scale with every piece in place.
  ///
  /// The sheet is 96 in long and 48 in wide. Each strip's width is written at
  /// its right end; the piece sizes are in the list that goes with the
  /// picture, because short pieces are too small to hold a measurement.
  AssemblyDiagram cutSheet(CutSheet sheet, {required int of}) {
    final is34 = sheet.material == PartMaterial.ply34;
    DiagramTone tone(LayoutPiece p) {
      if (!is34) return DiagramTone.back;
      return PartsBuilder.isNarrowStrip(p.name)
          ? DiagramTone.cleat
          : DiagramTone.panel;
    }

    final tops = sheet.stripTops;
    return AssemblyDiagram(
      caption:
          '${is34 ? '3/4"' : '1/4"'} sheet ${sheet.number} of $of, drawn to '
          'scale (${_f(Limits.sheetL)} long by ${_f(Limits.sheetW)} wide). '
          'The pale area is waste. The thin gaps between pieces are the saw '
          'kerf. Rip along the long direction first, then crosscut each '
          'strip. Sizes are in the list below the picture.',
      width: Limits.sheetL + 22,
      height: Limits.sheetW + 8,
      large: true,
      shapes: [
        DiagramShape.rect(
          0,
          0,
          Limits.sheetL,
          Limits.sheetW,
          tone: DiagramTone.ghost,
        ),
        for (final p in sheet.pieces)
          DiagramShape.rect(
            p.x,
            p.y,
            p.length,
            p.width,
            label: p.id,
            tone: tone(p),
          ),
      ],
      dimensions: [
        for (final t in tops)
          _dim(
            Limits.sheetL + 3,
            t,
            Limits.sheetL + 3,
            t + sheet.stripWidth(t),
            _f(sheet.stripWidth(t)),
          ),
        _dim(
          0,
          Limits.sheetW + 4,
          Limits.sheetL,
          Limits.sheetW + 4,
          _f(Limits.sheetL),
        ),
        // The length of every piece big enough to hold it. The rest are in the
        // list under the picture.
        for (final p in sheet.pieces)
          if (p.length >= 9 && p.width >= 6)
            DiagramDimension(
              _p(p.x + 0.8, p.y + p.width - 1.6),
              _p(p.x + p.length - 0.8, p.y + p.width - 1.6),
              _f(p.length),
              light: tone(p) == DiagramTone.panel,
            ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Finished states: checkpoints and the piece map

  /// The front of the unit drawn to scale with the id of every panel written
  /// beside it.
  ///
  /// Shelves are labelled just above their line at their left end, dividers at
  /// their top end just to the right, column panels just inside their column,
  /// and the four long panels inside the bars.
  ///
  /// Panels whose names are in [highlight] are drawn in the cleat tone, so a
  /// goal picture can show which parts the current stage builds.
  AssemblyDiagram elevation(
    Plan plan, {
    required String caption,
    Set<String> highlight = const {},
  }) {
    final ids = PieceIds(plan);
    final g = plan.geometry;
    final i = plan.inputs;
    const t = Limits.t;
    final counts = <String, int>{};
    final shapes = <DiagramShape>[
      DiagramShape.rect(
        g.windowBox.x,
        g.windowBox.y,
        g.windowBox.w,
        g.windowBox.h,
        label: 'window',
        tone: DiagramTone.ghost,
      ),
    ];
    final labels = <DiagramLabel>[];
    final bottomY = plan.ringH - plan.dimensions.kick;

    // The top of the gap between two shelves that is closest to the middle of
    // a column. The column panel ids are written at the top of that gap, and
    // the shelf ids at the bottom of it, so the two never stack.
    double midGap(String shelfName) {
      final ys = <double>[
        t,
        for (var k = 0; k < g.panels.length; k++)
          if (g.panelNames[k] == shelfName) g.panels[k].y,
        bottomY - t,
      ]..sort();
      var best = ys.first;
      var bestDist = double.infinity;
      for (var k = 0; k + 1 < ys.length; k++) {
        final d = ((ys[k] + ys[k + 1]) / 2 - plan.ringH / 2).abs();
        if (d < bestDist) {
          best = ys[k];
          bestDist = d;
        }
      }
      return best + 1.6;
    }

    final leftMid = midGap('Left column shelf');
    final rightMid = midGap('Right column shelf');
    const side = 2.6;
    for (var k = 0; k < g.panels.length; k++) {
      final name = g.panelNames[k];
      final b = g.panels[k];
      final n = counts[name] = (counts[name] ?? -1) + 1;
      final id = ids.id(name, n);
      shapes.add(
        DiagramShape.rect(
          b.x,
          b.y,
          b.w,
          b.h,
          tone: highlight.contains(name)
              ? DiagramTone.cleat
              : DiagramTone.panel,
        ),
      );
      final cx = b.x + b.w / 2;
      final DiagramPoint at;
      switch (name) {
        case 'Top panel':
          at = _p(i.left + 3, t + 1.3);
        case 'Bottom panel':
          at = _p(i.left + 3, b.y - 1.3);
        case 'Head panel' || 'Sill panel':
          at = _p(i.left + 3, b.y - 1.3);
        case 'Outer column panel':
          at = n == 0 ? _p(cx + side, leftMid) : _p(cx - side, rightMid);
        case 'Inner column panel':
          at = n == 0 ? _p(cx - side, leftMid) : _p(cx + side, rightMid);
        case 'Left column shelf' ||
            'Right column shelf' ||
            'Top bar shelf' ||
            'Bottom bar shelf':
          // At the left end of the shelf, not its middle: a long shelf has
          // dividers under it, and the middle is where one usually stands.
          at = _p(b.x + 2.4, b.y - 1.2);
        default:
          // A divider is named at its top end, just right of it. The shelf ids
          // are at the bottom of the opening, so the two never meet, and a
          // tier line halfway up a bar divider stays clear.
          at = _p(cx + side, b.y + 1.6);
      }
      labels.add(DiagramLabel(at, id));
    }
    final kick = g.toeKickBox;
    if (kick != null) {
      shapes.add(
        DiagramShape.rect(
          kick.x,
          kick.y,
          kick.w,
          kick.h,
          label: ids.id(PartsBuilder.toeKickName),
          tone: DiagramTone.cleat,
        ),
      );
    }
    return AssemblyDiagram(
      caption: caption,
      width: plan.ringW,
      height: plan.ringH,
      shapes: shapes,
      labels: labels,
      large: true,
    );
  }

  /// The finished unit seen from the side, cut through the left column, to
  /// scale.
  ///
  /// It shows every horizontal panel across the depth, the 1/4" back and the
  /// toe kick, so a builder can compare depth, shelf heights and the back with
  /// their own work. Panels whose names are in [highlight] use the cleat tone.
  AssemblyDiagram sideView(
    Plan plan, {
    required String caption,
    Set<String> highlight = const {},
  }) {
    final ids = PieceIds(plan);
    final g = plan.geometry;
    final depth = plan.depthPanel;
    const cut = {
      'Top panel',
      'Bottom panel',
      'Head panel',
      'Sill panel',
      'Left column shelf',
    };
    final counts = <String, int>{};
    final shapes = <DiagramShape>[];
    for (var k = 0; k < g.panels.length; k++) {
      final name = g.panelNames[k];
      final n = counts[name] = (counts[name] ?? -1) + 1;
      if (!cut.contains(name)) continue;
      final b = g.panels[k];
      shapes.add(
        DiagramShape.rect(
          0,
          b.y,
          depth,
          b.h,
          label: ids.id(name, n),
          tone: highlight.contains(name)
              ? DiagramTone.cleat
              : DiagramTone.panel,
        ),
      );
    }
    shapes.add(
      DiagramShape.rect(
        depth,
        0,
        Limits.backT,
        plan.ringH,
        label: 'back',
        tone: DiagramTone.back,
      ),
    );
    final kick = g.toeKickBox;
    if (kick != null) {
      shapes.add(
        DiagramShape.rect(
          2,
          kick.y,
          depth - 2,
          kick.h,
          label: ids.id(PartsBuilder.toeKickName),
          tone: DiagramTone.cleat,
        ),
      );
    }
    return AssemblyDiagram(
      caption: caption,
      width: depth + Limits.backT,
      height: plan.ringH,
      shapes: shapes,
    );
  }

  /// A finished column with every shelf and both panels labelled.
  AssemblyDiagram columnDone(Plan plan, {required bool left}) {
    final ids = PieceIds(plan);
    final c = left ? plan.leftCol : plan.rightCol;
    final shelfName = left ? 'Left column shelf' : 'Right column shelf';
    final outer = ids.id('Outer column panel', left ? 0 : 1);
    final inner = ids.id('Inner column panel', left ? 0 : 1);
    final u = _columnScale(plan, c);
    final tk = Limits.t * u;
    const x0 = 40.0;
    const top = 14.0;
    final bottom = top + plan.sideH * u;
    double yAt(double pos) => bottom - pos * u;
    final xi = x0 + tk + c.clearW * u;
    return AssemblyDiagram(
      caption:
          'Front view of the finished ${left ? 'left' : 'right'} column, '
          'drawn to scale. $outer and $inner are the two tall panels, with '
          '${c.shelves} ${c.shelves == 1 ? 'shelf' : 'shelves'} between them '
          'at the heights you marked.',
      width: xi + tk + 20,
      height: bottom + 8,
      shapes: [
        DiagramShape.rect(x0, top, tk, plan.sideH * u),
        for (var k = 0; k < c.shelves; k++)
          DiagramShape.rect(
            x0 + tk,
            yAt(shelfPos(plan, left: left, k: k + 1)) - tk,
            c.clearW * u,
            tk,
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(xi, top, tk, plan.sideH * u),
      ],
      labels: [
        DiagramLabel(_p(x0 + tk / 2, top - 7), outer),
        DiagramLabel(_p(xi + tk / 2, top - 7), inner),
        for (var k = 0; k < c.shelves; k++)
          DiagramLabel(
            _p(
              x0 + tk + c.clearW * u / 2,
              yAt(shelfPos(plan, left: left, k: k + 1)) - tk - 5,
            ),
            ids.id(shelfName, k),
          ),
      ],
    );
  }

  /// A finished bar with its skins and dividers labelled.
  AssemblyDiagram barDone(Plan plan, {required bool top}) {
    final ids = PieceIds(plan);
    final b = top ? plan.topBar : plan.bottomBar;
    final long = ids.id(_longName(top));
    final short = ids.id(_shortName(top));
    final u = math.min(230 / plan.ringW, 60 / (b.dividerLength + 2 * Limits.t));
    final tk = Limits.t * u;
    final dk = b.dividerLength * u;
    const x0 = 5.0;
    const y0 = 14.0;
    final yLong = top ? y0 : y0 + tk + dk;
    final yShort = top ? y0 + tk + dk : y0;
    return AssemblyDiagram(
      caption:
          'Front view of the finished ${top ? 'top' : 'bottom'} bar unit, '
          'drawn to scale. The long panel ($long) is the outer skin and '
          'sticks out at both ends, the short panel ($short) is the inner '
          'skin, and the dividers stand between them.',
      width: plan.ringW * u + 2 * x0,
      height: y0 + dk + 2 * tk + 14,
      shapes: [
        DiagramShape.rect(x0, yLong, plan.ringW * u, tk),
        DiagramShape.rect(
          x0 + plan.inputs.left * u,
          yShort,
          plan.inputs.openW * u,
          tk,
        ),
        for (var m = 1; m <= b.dividers; m++)
          DiagramShape.rect(
            x0 + dividerPos(plan, top: top, m: m) * u,
            y0 + tk,
            tk,
            dk,
            tone: DiagramTone.cleat,
          ),
      ],
      labels: [
        DiagramLabel(
          _p(x0 + plan.ringW * u / 2, top ? y0 - 7 : y0 + 2 * tk + dk + 7),
          long,
        ),
        DiagramLabel(
          _p(x0 + plan.ringW * u / 2, top ? y0 + 2 * tk + dk + 7 : y0 - 7),
          short,
        ),
        for (var m = 1; m <= b.dividers; m++)
          DiagramLabel(
            _p(
              x0 + dividerPos(plan, top: top, m: m) * u + tk + 8,
              y0 + tk + dk / 2,
            ),
            ids.id(_divName(top), m - 1),
          ),
      ],
    );
  }

  /// A side cut of the finished hang.
  AssemblyDiagram mount(Plan plan) {
    final ids = PieceIds(plan);
    final wall = ids.cleat(0, wall: true);
    final unit = ids.cleat(0, wall: false);
    // A cut away section 16" tall, centered on the cleat. Wall, unit and back
    // are drawn at their real thickness and depth.
    const wallT = 2.0;
    const viewH = 16.0;
    final total = wallT + Limits.t + Limits.backT + plan.depthPanel;
    final u = 150 / total;
    final tk = Limits.t * u;
    final w = Limits.anchorCleatW * u;
    final x0 = wallT * u;
    final hookedH = 2 * w - tk;
    final yTop = 10 + (viewH * u - hookedH) / 2;
    final yWall = yTop + w - tk;
    return AssemblyDiagram(
      caption:
          'Side view of the unit hung on the cleat, drawn to scale and cut '
          'away above and below. The wall piece ($wall) is screwed to the '
          'wall and the unit piece ($unit) is on the back of the unit. Lower '
          'the unit until the two slopes lock. The unit stands about '
          '${_f(Limits.t)} off the wall.',
      width: 170,
      height: 10 + viewH * u + 22,
      shapes: [
        DiagramShape.rect(
          0,
          10,
          x0,
          viewH * u,
          label: 'wall',
          tone: DiagramTone.wall,
        ),
        DiagramShape([
          _p(x0, yWall + tk),
          _p(x0 + tk, yWall),
          _p(x0 + tk, yWall + w),
          _p(x0, yWall + w),
        ], tone: DiagramTone.cleat),
        DiagramShape([
          _p(x0, yTop),
          _p(x0 + tk, yTop),
          _p(x0 + tk, yTop + w - tk),
          _p(x0, yTop + w),
        ]),
        DiagramShape.rect(
          x0 + tk,
          10,
          Limits.backT * u,
          viewH * u,
          tone: DiagramTone.back,
        ),
        DiagramShape.rect(
          x0 + tk + Limits.backT * u,
          10,
          plan.depthPanel * u,
          viewH * u,
          label: 'unit',
          tone: DiagramTone.ghost,
        ),
      ],
      labels: [
        DiagramLabel(
          _p(x0 + tk + Limits.backT * u + 12, yWall + w * 0.6),
          wall,
        ),
        DiagramLabel(_p(x0 + tk + Limits.backT * u + 12, yTop + w * 0.3), unit),
      ],
      arrows: [_arrow(x0 + tk + 30, 12, x0 + tk + 30, 12 + 30)],
      dimensions: [
        _dim(
          x0,
          10 + viewH * u + 12,
          x0 + tk,
          10 + viewH * u + 12,
          _f(Limits.t),
        ),
      ],
    );
  }
}
