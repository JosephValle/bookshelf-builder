import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
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
/// The pictures are schematic and not to scale. Piece ids, measurements and
/// fastener distances always match the cut list and the guide.
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

  /// Centers of [n] items spread evenly between [from] and [to].
  List<double> _spread(int n, double from, double to) => [
    for (var k = 0; k < n; k++) from + (to - from) * (k + 1) / (n + 1),
  ];

  int _perJoint(Plan plan) => Fasteners.screwsPerJoint(plan.depthPanel);

  // ---------------------------------------------------------------------
  // French cleat

  /// The wall half and the unit half of the French cleat, apart and hooked.
  AssemblyDiagram cleatPair(Plan plan) {
    final ids = PieceIds(plan);
    final wall = ids.cleat(0, wall: true);
    final unit = ids.cleat(0, wall: false);
    DiagramShape wallPiece(double x, {String l = ''}) => DiagramShape(
      [_p(x, 70), _p(x + 24, 46), _p(x + 24, 100), _p(x, 100)],
      label: l,
      tone: DiagramTone.cleat,
    );
    DiagramShape unitPiece(double x, {String l = ''}) => DiagramShape([
      _p(x, 16),
      _p(x + 24, 16),
      _p(x + 24, 46),
      _p(x, 70),
    ], label: l);
    return AssemblyDiagram(
      caption:
          'Side view of the two halves. Left: the wall piece ($wall) and the '
          'unit piece ($unit) as cut. Right: hooked together. The sloped '
          'edges slide together and the weight pulls them tight.',
      width: 250,
      height: 112,
      shapes: [
        wallPiece(20, l: wall),
        unitPiece(90, l: unit),
        wallPiece(170),
        unitPiece(170),
      ],
      arrows: [_arrow(182, 4, 182, 14)],
      pieces: _use([(wall, 'wall French cleat'), (unit, 'unit French cleat')]),
    );
  }

  // ---------------------------------------------------------------------
  // Columns

  double _under(double pos, double sideH) => 144 - pos * (132 / sideH);

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
    return AssemblyDiagram(
      caption:
          'Lay the outer panel ($outer) and the inner panel ($inner) side by '
          'side and clamp them. Measure up from the bottom end and draw each '
          'shelf line across both. Each line is the underside of a shelf.',
      width: 170,
      height: 152,
      shapes: [
        DiagramShape.rect(60, 6, 14, 138, label: outer),
        DiagramShape.rect(78, 6, 14, 138, label: inner),
        for (var k = 1; k <= c.shelves; k++)
          DiagramShape.rect(
            56,
            _under(shelfPos(plan, left: left, k: k), plan.sideH) - 1,
            40,
            1.5,
            tone: DiagramTone.cleat,
          ),
      ],
      dimensions: [
        if (c.shelves >= 1)
          _dim(
            40,
            144,
            40,
            _under(shelfPos(plan, left: left, k: 1), plan.sideH),
            _f(c.clearH),
          ),
        if (c.shelves >= 2)
          _dim(
            40,
            _under(shelfPos(plan, left: left, k: 1), plan.sideH),
            40,
            _under(shelfPos(plan, left: left, k: 2), plan.sideH),
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
    final y = _under(shelfPos(plan, left: left, k: k + 1), plan.sideH);
    return AssemblyDiagram(
      caption:
          'Front view. Stand shelf $cur on its line on the outer panel '
          '($outer), ${_f(shelfPos(plan, left: left, k: k + 1))} up from the '
          'bottom end to the underside of the shelf. Shelves already in '
          'place are shown pale.',
      width: 170,
      height: 152,
      shapes: [
        DiagramShape.rect(20, 6, 14, 138, label: outer),
        for (var i = 0; i < c.shelves; i++)
          if (i != k)
            DiagramShape.rect(
              34,
              _under(shelfPos(plan, left: left, k: i + 1), plan.sideH) - 5,
              76,
              5,
              label: i < k ? ids.id(shelfName, i) : '',
              tone: DiagramTone.ghost,
            ),
        DiagramShape.rect(34, y - 5, 76, 5, label: cur),
      ],
      arrows: [_arrow(148, y - 2.5, 114, y - 2.5)],
      marks: [_screw(27, y - 2.5)],
      dimensions: [
        _dim(8, 144, 8, y, _f(shelfPos(plan, left: left, k: k + 1))),
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
    return AssemblyDiagram(
      caption:
          'Screw placement. Looking at the outside face of $panelId. The '
          'band is where $bandName $bandId meets it from behind. Drive $n '
          'screws through $panelId into the end of $bandId: '
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
        DiagramShape.rect(10, 45, 200, 20, tone: DiagramTone.cleat),
      ],
      marks: [
        for (var k = 0; k < n; k++)
          _screw(first + (last - first) * k / (n - 1), 55),
      ],
      dimensions: [
        _dim(10, 108, first, 108, _f(Fasteners.edgeInset)),
        _dim(last, 108, 210, 108, _f(Fasteners.edgeInset)),
        _dim(222, 65, 222, 55, _f(Limits.t / 2)),
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
    final s = 150 / c.clearW;
    double x(int m) => 24 + s * (m * c.bayW + (m - 1) * Limits.t);
    final m = index + 1;
    final dist = m * c.bayW + (m - 1) * Limits.t;
    return AssemblyDiagram(
      caption:
          'Front view of one opening. Stand divider $cur between $below '
          '(below) and $above (above), ${_f(dist)} from the face of the '
          'outer panel ($outer). Dividers already in place are shown pale.',
      width: 204,
      height: 130,
      shapes: [
        DiagramShape.rect(
          10,
          20,
          14,
          92,
          label: outer,
          tone: DiagramTone.ghost,
        ),
        DiagramShape.rect(
          174,
          20,
          14,
          92,
          label: inner,
          tone: DiagramTone.ghost,
        ),
        DiagramShape.rect(
          24,
          14,
          150,
          8,
          label: above,
          tone: DiagramTone.ghost,
        ),
        DiagramShape.rect(
          24,
          110,
          150,
          8,
          label: below,
          tone: DiagramTone.ghost,
        ),
        for (var i = 1; i < m; i++)
          DiagramShape.rect(
            x(i),
            22,
            7,
            88,
            label: ids.id(divName, opening * c.dividers + i - 1),
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(x(m), 22, 7, 88, label: cur),
      ],
      marks: [_screw(x(m) + 3.5, 30), _screw(x(m) + 3.5, 102)],
      dimensions: [_dim(24, 126, x(m), 126, _f(dist))],
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
    return AssemblyDiagram(
      caption:
          'Front view. Lay the inner panel ($inner) on the free ends of the '
          'shelves, with its bottom end level with $outer and its shelf '
          'lines over the shelf ends. Then screw through it into every '
          'shelf.',
      width: 200,
      height: 152,
      shapes: [
        DiagramShape.rect(
          20,
          6,
          14,
          138,
          label: outer,
          tone: DiagramTone.ghost,
        ),
        for (var i = 0; i < c.shelves; i++)
          DiagramShape.rect(
            34,
            _under(shelfPos(plan, left: left, k: i + 1), plan.sideH) - 5,
            96,
            5,
            label: ids.id(shelfName, i),
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(152, 6, 14, 138, label: inner),
      ],
      arrows: [_arrow(180, 75, 168, 75)],
      marks: [
        for (var i = 0; i < c.shelves; i++)
          _screw(
            159,
            _under(shelfPos(plan, left: left, k: i + 1), plan.sideH) - 2.5,
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
    const dw = 150.0;
    final dh = math.min(100.0, math.max(30.0, dw * h / w));
    final scaleH = h > w ? 100.0 : dh;
    final rw = h > w ? 100 * w / h : dw;
    final rh = h > w ? 100.0 : scaleH;
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
    return AssemblyDiagram(
      caption:
          'Rest ${top ? 'the top' : 'the bottom'} panel ($long) flat on blocks '
          'with its inside face up and the front edge toward you. The shaded part is '
          'the bar; the panel sticks out ${_f(plan.inputs.left)} on the left '
          'and ${_f(plan.inputs.right)} on the right where the columns will '
          'go. Draw a line for each divider, measured from the left end of '
          'the panel. Each line is the left face of a divider.',
      width: 260,
      height: 112,
      shapes: [
        DiagramShape.rect(10, 10, 230, 70, tone: DiagramTone.ghost),
        DiagramShape.rect(
          x(plan.inputs.left),
          10,
          plan.inputs.openW * sx,
          70,
          tone: DiagramTone.back,
        ),
        for (var m = 1; m <= b.dividers; m++)
          DiagramShape.rect(
            x(dividerPos(plan, top: top, m: m)),
            10,
            2,
            70,
            tone: DiagramTone.cleat,
          ),
        _chip(12, 84, long),
      ],
      dimensions: [
        if (b.dividers >= 1)
          _dim(
            10,
            100,
            x(dividerPos(plan, top: top, m: 1)),
            100,
            _f(dividerPos(plan, top: top, m: 1)),
          ),
        if (b.dividers >= 2)
          _dim(
            x(dividerPos(plan, top: top, m: 1)),
            92,
            x(dividerPos(plan, top: top, m: 2)),
            92,
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
    final double nh = 70 * math.min(Limits.anchorCleatW / b.dividerLength, 1.0);
    const nw = 12.0;
    return AssemblyDiagram(
      caption:
          'Side view of a divider. The back is on the left. Cut a notch '
          '${_f(Limits.t)} deep and ${_f(Limits.anchorCleatW)} tall out of the '
          'back ${top ? 'top' : 'bottom'} corner of every divider (each '
          '${_f(b.dividerLength)} long) so the anchor cleat sits flush.',
      width: 190,
      height: 100,
      shapes: [
        DiagramShape(
          top
              ? [
                  _p(10 + nw, 14),
                  _p(160, 14),
                  _p(160, 84),
                  _p(10, 84),
                  _p(10, 14 + nh),
                  _p(10 + nw, 14 + nh),
                ]
              : [
                  _p(10, 14),
                  _p(160, 14),
                  _p(160, 84 - nh),
                  _p(10 + nw, 84 - nh),
                  _p(10 + nw, 84),
                  _p(10, 84),
                ],
          label: div,
        ),
      ],
      dimensions: [
        _dim(10, 8, 10 + nw, 8, _f(Limits.t)),
        if (top)
          _dim(4, 14, 4, 14 + nh, _f(Limits.anchorCleatW))
        else
          _dim(4, 84 - nh, 4, 84, _f(Limits.anchorCleatW)),
      ],
      pieces: _use([(div, 'divider')]),
    );
  }

  /// A divider being screwed to the long panel.
  AssemblyDiagram barDivider(Plan plan, {required bool top, required int k}) {
    final ids = PieceIds(plan);
    final long = ids.id(_longName(top));
    final sx = _sx(plan);
    final d = plan.depthPanel;
    final s = 70 / d;
    final n = _perJoint(plan);
    final firstY = 10 + s * Fasteners.edgeInset;
    final lastY = 80 - s * Fasteners.edgeInset;
    double x(int m) =>
        10 + (dividerPos(plan, top: top, m: m) + Limits.t / 2) * sx;
    final cur = ids.id(_divName(top), k);
    final m = k + 1;
    return AssemblyDiagram(
      caption:
          'Looking at the outside face of the long panel ($long). Stand '
          'divider $cur on its end on line $m, ${_f(dividerPos(plan, top: top, m: m))} '
          'from the left end, with its front edge level with the front edge '
          'of the panel. From underneath, drive $n screws up through the panel into it, '
          '${_f(Fasteners.edgeInset)} in from the front and back edges. '
          'Dividers already fixed are shown pale.',
      width: 260,
      height: 112,
      shapes: [
        DiagramShape.rect(10, 10, 230, 70, tone: DiagramTone.ghost),
        _chip(12, 84, long),
        for (var i = 1; i < m; i++)
          DiagramShape.rect(
            x(i) - 7,
            10,
            14,
            70,
            label: ids.id(_divName(top), i - 1),
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(
          x(m) - 7,
          10,
          14,
          70,
          label: cur,
          tone: DiagramTone.cleat,
        ),
      ],
      marks: [
        for (var j = 0; j < n; j++)
          _screw(x(m), firstY + (lastY - firstY) * j / (n - 1)),
      ],
      dimensions: [
        _dim(250, 10, 250, firstY, _f(Fasteners.edgeInset)),
        _dim(250, lastY, 250, 80, _f(Fasteners.edgeInset)),
        _dim(
          10,
          100,
          x(m) - Limits.t / 2 * sx,
          100,
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
    final d = plan.depthPanel;
    final s = 70 / d;
    final n = _perJoint(plan);
    final firstY = 10 + s * Fasteners.edgeInset;
    final lastY = 80 - s * Fasteners.edgeInset;
    final x0 = 10 + plan.inputs.left * sx;
    double x(int m) =>
        10 + (dividerPos(plan, top: top, m: m) + Limits.t / 2) * sx;
    return AssemblyDiagram(
      caption:
          'Lay the '
          '${top ? 'head' : 'sill'} panel ($short) on top of the dividers, level '
          'with the ends of the bar and with the front edges. It is '
          '${_f(plan.inputs.openW)} long, so it stops ${_f(plan.inputs.left)} '
          'short of the left end of $long. Drive $n screws down through it '
          'into each divider, ${_f(Fasteners.edgeInset)} in from the front '
          'and back edges.',
      width: 260,
      height: 112,
      shapes: [
        DiagramShape.rect(x0, 10, plan.inputs.openW * sx, 70),
        _chip(12, 84, short),
        for (var m = 1; m <= b.dividers; m++)
          DiagramShape.rect(x(m) - 1, 10, 2, 70, tone: DiagramTone.cleat),
      ],
      marks: [
        for (var m = 1; m <= b.dividers; m++)
          for (var j = 0; j < n; j++)
            _screw(x(m), firstY + (lastY - firstY) * j / (n - 1)),
      ],
      dimensions: [
        _dim(250, 10, 250, firstY, _f(Fasteners.edgeInset)),
        _dim(250, lastY, 250, 80, _f(Fasteners.edgeInset)),
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
    return AssemblyDiagram(
      caption:
          'Side cut through the bar. The back is on the left. Glue the anchor '
          'cleat ($cleat) into the notches, tight against the '
          '${top ? 'top' : 'bottom'} skin, and screw it to every divider '
          '($div). This solid piece is where the wall anchors bite.',
      width: 176,
      height: 112,
      shapes: [
        DiagramShape.rect(6, 10, 8, 90, label: back, tone: DiagramTone.back),
        DiagramShape.rect(14, 10, 120, 10, label: skinTop),
        DiagramShape.rect(14, 90, 120, 10, label: skinBottom),
        DiagramShape(
          top
              ? [
                  _p(24, 20),
                  _p(134, 20),
                  _p(134, 90),
                  _p(14, 90),
                  _p(14, 55),
                  _p(24, 55),
                ]
              : [
                  _p(14, 20),
                  _p(134, 20),
                  _p(134, 90),
                  _p(24, 90),
                  _p(24, 55),
                  _p(14, 55),
                ],
          label: div,
        ),
        DiagramShape.rect(
          14,
          top ? 20 : 55,
          10,
          35,
          label: cleat,
          tone: DiagramTone.cleat,
        ),
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
    final bw = 200 / n;
    return AssemblyDiagram(
      caption:
          'Front view of the bar. Fit shelf $cur in bay ${k + 1}, level with '
          'the middle of the bar, and screw through each divider into its '
          'ends.',
      width: 220,
      height: 100,
      shapes: [
        DiagramShape.rect(10, 10, 200, 8, tone: DiagramTone.ghost),
        DiagramShape.rect(10, 82, 200, 8, tone: DiagramTone.ghost),
        for (var i = 1; i < n; i++)
          DiagramShape.rect(
            10 + bw * i - 3,
            18,
            6,
            64,
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(10 + bw * k + 3, 47, bw - 6, 6, label: cur),
      ],
      arrows: [_arrow(10 + bw * k + bw / 2, 30, 10 + bw * k + bw / 2, 44)],
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
    final colY = stage == 1 || stage == 2 ? 64.0 : 50.0;
    final barY = stage == 3 ? 156.0 : 131.0;
    return AssemblyDiagram(
      caption:
          'Top view of the unit lying on its back on the floor, top of the '
          'unit at the top of the picture. ${switch (stage) {
            0 => 'Lay the top bar unit down first.',
            1 => 'Slide the left column up against the top panel.',
            2 => 'Slide the right column up against the top panel.',
            _ => 'Slide the bottom bar unit up onto the column ends.',
          }}',
      width: 240,
      height: 200,
      shapes: [
        DiagramShape.rect(0, 4, 240, 40, label: 'Top bar unit', tone: tone(0)),
        if (stage >= 1)
          DiagramShape.rect(
            0,
            stage == 1 ? colY : 50,
            50,
            75,
            label: 'Left column',
            tone: tone(1),
          ),
        if (stage >= 2)
          DiagramShape.rect(
            190,
            stage == 2 ? colY : 50,
            50,
            75,
            label: 'Right column',
            tone: tone(2),
          ),
        if (stage >= 1)
          DiagramShape.rect(
            50,
            50,
            140,
            75,
            label: 'window',
            tone: DiagramTone.ghost,
          ),
        if (stage >= 3)
          DiagramShape.rect(
            0,
            barY,
            240,
            40,
            label: 'Bottom bar unit',
            tone: tone(3),
          ),
      ],
      arrows: [
        if (stage == 1) _arrow(25, 62, 25, 48),
        if (stage == 2) _arrow(215, 62, 215, 48),
        if (stage == 3) _arrow(120, 154, 120, 130),
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
    final s = 70 / plan.depthPanel;
    final firstY = 10 + s * Fasteners.edgeInset;
    final lastY = 80 - s * Fasteners.edgeInset;
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
          'panel ($long). Stand the ${left ? 'left' : 'right'} column on it: '
          'the outer panel ($outer) level with the ${left ? 'left' : 'right'} '
          'end of the panel, and the inner panel ($inner) '
          '${_f(left ? i.left - Limits.t : i.right - Limits.t)} in from that end, on '
          'the bar side of the column. Both stand flush with the front '
          'edge. Drive $n screws through the panel into the end of each, '
          '${_f(Fasteners.edgeInset)} in from the front and back edges.',
      width: 260,
      height: 112,
      shapes: [
        DiagramShape.rect(10, 10, 230, 70, tone: DiagramTone.ghost),
        _chip(12, 84, long),
        for (final ox in other)
          DiagramShape.rect(ox - 4, 10, 8, 70, tone: DiagramTone.ghost),
        DiagramShape.rect(x(xOuter) - 4, 10, 8, 70, tone: DiagramTone.cleat),
        DiagramShape.rect(x(xInner) - 4, 10, 8, 70, tone: DiagramTone.cleat),
        _chip(40, 84, outer),
        _chip(68, 84, inner),
      ],
      marks: [
        for (final cx in [x(xOuter), x(xInner)])
          for (var j = 0; j < n; j++)
            _screw(cx, firstY + (lastY - firstY) * j / (n - 1)),
      ],
      dimensions: [
        _dim(250, 10, 250, firstY, _f(Fasteners.edgeInset)),
        _dim(250, lastY, 250, 80, _f(Fasteners.edgeInset)),
        if (left)
          _dim(
            10,
            102,
            x(innerFace) + 0,
            102,
            _f(left ? i.left - Limits.t : i.right - Limits.t),
          )
        else
          _dim(x(innerFace), 102, 240, 102, _f(i.right - Limits.t)),
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
    return AssemblyDiagram(
      caption:
          'Side view. The front is on the right. Glue blocks cut from '
          'offcuts under the bottom panel ($bottom), set back from the '
          'front, then screw the toe kick ($kick) to them about every '
          '${_f(Fasteners.toeKickSpacing)}.',
      width: 170,
      height: 96,
      shapes: [
        DiagramShape.rect(20, 4, 120, 40, tone: DiagramTone.ghost),
        DiagramShape.rect(20, 44, 120, 10, label: bottom),
        DiagramShape.rect(104, 54, 12, 26, tone: DiagramTone.cleat),
        DiagramShape.rect(116, 54, 8, 26, label: kick),
      ],
      marks: [_screw(120, 67)],
      arrows: [_arrow(150, 67, 128, 67)],
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
    final rects = [
      (0.0, 0.0, 50.0, 160.0),
      (190.0, 0.0, 50.0, 160.0),
      (50.0, 0.0, 140.0, 50.0),
      (50.0, 110.0, 140.0, 50.0),
    ];
    final id = ids.id(_backNames[current]);
    return AssemblyDiagram(
      caption:
          'Back view. Lay back panel $id on the ${const ['left column', 'right column', 'top bar', 'bottom bar'][current]}, level with its outer edges. Backs already fixed are '
          'shown pale.',
      width: 240,
      height: 160,
      shapes: [
        for (var i = 0; i < 4; i++)
          if (i <= current)
            DiagramShape.rect(
              rects[i].$1,
              rects[i].$2,
              rects[i].$3,
              rects[i].$4,
              label: ids.id(_backNames[i]),
              tone: i == current ? DiagramTone.back : DiagramTone.ghost,
            ),
        DiagramShape.rect(
          50,
          50,
          140,
          60,
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
    return AssemblyDiagram(
      caption:
          'Nail placement on back panel $backId (a corner). Brads go '
          '${_f(Fasteners.nailInset)} in from every edge and no more than '
          '${_f(Fasteners.nailSpacing)} apart. Also nail into every shelf '
          'and divider behind it (the dark band), at the same spacing.',
      width: 254,
      height: 122,
      shapes: [
        DiagramShape.rect(10, 10, 220, 100, tone: DiagramTone.back),
        DiagramShape.rect(10, 56, 220, 10, tone: DiagramTone.cleat),
        _chip(12, 94, backId),
      ],
      marks: [
        for (final x in [24.0, 24.0 + gap, 24.0 + 2 * gap]) ...[
          DiagramMark(_p(x, 10 + inset), kind: DiagramMarkKind.nail),
          DiagramMark(_p(x, 61), kind: DiagramMarkKind.nail),
        ],
        DiagramMark(_p(10 + inset, 90), kind: DiagramMarkKind.nail),
      ],
      dimensions: [
        _dim(242, 10, 242, 10 + inset, _f(Fasteners.nailInset)),
        _dim(24, 116, 24 + gap, 116, _f(Fasteners.nailSpacing)),
      ],
    );
  }

  static const List<(double, double)> _cleatSpots = [
    (4.0, 22.0),
    (4.0, 84.0),
    (194.0, 22.0),
    (194.0, 84.0),
  ];

  /// The back of the unit with the unit half of the cleat; piece [current]
  /// (0 to 3) is being fixed.
  AssemblyDiagram unitCleat(Plan plan, {required int current}) {
    final ids = PieceIds(plan);
    String sub(int i) => ids.cleat(i, wall: false);
    final left = current < 2;
    return AssemblyDiagram(
      caption:
          'Back view, unit face down. Fix piece ${sub(current)} to the '
          '${left ? 'left' : 'right'} column, ${current.isEven ? 'near the top' : 'near the middle'}. '
          'Pieces already fixed are shown pale.',
      width: 240,
      height: 160,
      shapes: [
        DiagramShape.rect(0, 0, 50, 160, tone: DiagramTone.ghost),
        DiagramShape.rect(50, 0, 140, 50, tone: DiagramTone.ghost),
        DiagramShape.rect(50, 110, 140, 50, tone: DiagramTone.ghost),
        DiagramShape.rect(190, 0, 50, 160, tone: DiagramTone.ghost),
        for (var i = 0; i <= current; i++)
          DiagramShape.rect(
            _cleatSpots[i].$1,
            _cleatSpots[i].$2,
            42,
            12,
            label: sub(i),
            tone: i == current ? DiagramTone.cleat : DiagramTone.ghost,
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
    if (!wall) {
      final s = 230 / len;
      final gaps = math.max(
        1,
        ((len - 2 * Fasteners.cleatEndInset) / Fasteners.screwSpacing).ceil(),
      );
      final first = 10 + s * Fasteners.cleatEndInset;
      final last = 240 - s * Fasteners.cleatEndInset;
      final xs = [
        for (var k = 0; k <= gaps; k++) first + (last - first) * k / gaps,
      ];
      return AssemblyDiagram(
        caption:
            'Screw placement. The face of unit cleat piece $id, ${_f(len)} '
            'long, centered on a shelf. Put a screw ${_f(Fasteners.cleatEndInset)} '
            'from each end and one at least every '
            '${_f(Fasteners.screwSpacing)} between, along the middle of the '
            'strip, through the back panel into the shelf edge.',
        width: 262,
        height: 100,
        shapes: [
          DiagramShape.rect(
            10,
            20,
            230,
            44,
            label: id,
            tone: DiagramTone.cleat,
          ),
        ],
        marks: [for (final x in xs) _screw(x, 42)],
        dimensions: [
          _dim(10, 80, first, 80, _f(Fasteners.cleatEndInset)),
          _dim(last, 80, 240, 80, _f(Fasteners.cleatEndInset)),
          if (xs.length > 1)
            _dim(xs[0], 92, xs[1], 92, '${_f(Fasteners.screwSpacing)} or less'),
        ],
      );
    }
    if (plan.inputs.concreteWall) {
      final s = 230 / len;
      final gaps = math.max(
        1,
        ((len - 2 * Fasteners.concreteEndInset) / Fasteners.concreteSpacing)
            .ceil(),
      );
      final first = 10 + s * Fasteners.concreteEndInset;
      final last = 240 - s * Fasteners.concreteEndInset;
      final xs = [
        for (var k = 0; k <= gaps; k++) first + (last - first) * k / gaps,
      ];
      const rowY = 44 / Limits.anchorCleatW;
      return AssemblyDiagram(
        caption:
            'Screw placement. The face of wall cleat piece $id, ${_f(len)} '
            'long, on a concrete wall. Drive a pair of concrete screws '
            '${_f(Fasteners.concreteEndInset)} from each end, and another '
            'pair at least every ${_f(Fasteners.concreteSpacing)} between. In '
            'each pair, one screw is ${_f(Fasteners.wallScrewEdgeInset)} '
            'below the top edge and one ${_f(Fasteners.wallScrewEdgeInset)} '
            'above the bottom edge.',
        width: 262,
        height: 114,
        shapes: [
          DiagramShape.rect(
            10,
            24,
            230,
            44,
            label: id,
            tone: DiagramTone.cleat,
          ),
        ],
        marks: [
          for (final x in xs) ...[
            _screw(x, 24 + rowY * Fasteners.wallScrewEdgeInset),
            _screw(x, 68 - rowY * Fasteners.wallScrewEdgeInset),
          ],
        ],
        dimensions: [
          _dim(10, 84, first, 84, _f(Fasteners.concreteEndInset)),
          _dim(last, 84, 240, 84, _f(Fasteners.concreteEndInset)),
          if (xs.length > 1)
            _dim(
              xs[0],
              98,
              xs[1],
              98,
              '${_f(Fasteners.concreteSpacing)} or less',
            ),
          _dim(
            250,
            24,
            250,
            24 + rowY * Fasteners.wallScrewEdgeInset,
            _f(Fasteners.wallScrewEdgeInset),
          ),
          _dim(
            250,
            68 - rowY * Fasteners.wallScrewEdgeInset,
            250,
            68,
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
    const sy = 44 / Limits.anchorCleatW;
    const studs = [70.0, 178.0];
    return AssemblyDiagram(
      caption:
          'Screw placement. The face of wall cleat piece $id, ${_f(len)} '
          'long, over two studs. Drive two screws into every stud it '
          'crosses: one ${_f(Fasteners.wallScrewEdgeInset)} below the top edge '
          'and one ${_f(Fasteners.wallScrewEdgeInset)} above the bottom edge. '
          'Studs are usually ${_f(plan.inputs.studSpacing)} apart.',
      width: 262,
      height: 114,
      shapes: [
        for (final x in studs)
          DiagramShape.rect(x - 8, 8, 16, 76, tone: DiagramTone.ghost),
        DiagramShape.rect(10, 24, 230, 44, label: id, tone: DiagramTone.cleat),
      ],
      marks: [
        for (final x in studs) ...[
          _screw(x, 24 + sy * Fasteners.wallScrewEdgeInset),
          _screw(x, 68 - sy * Fasteners.wallScrewEdgeInset),
        ],
      ],
      dimensions: [
        _dim(
          250,
          24,
          250,
          24 + sy * Fasteners.wallScrewEdgeInset,
          _f(Fasteners.wallScrewEdgeInset),
        ),
        _dim(
          250,
          68 - sy * Fasteners.wallScrewEdgeInset,
          250,
          68,
          _f(Fasteners.wallScrewEdgeInset),
        ),
        _dim(studs[0], 100, studs[1], 100, _f(plan.inputs.studSpacing)),
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
    return AssemblyDiagram(
      caption:
          'Front view of the finished ${left ? 'left' : 'right'} column. '
          '$outer and $inner are the two tall panels, with '
          '${c.shelves} ${c.shelves == 1 ? 'shelf' : 'shelves'} between them '
          'at the heights you marked. Not to scale.',
      width: 150,
      height: 152,
      shapes: [
        DiagramShape.rect(20, 6, 14, 138, label: outer),
        for (var k = 0; k < c.shelves; k++)
          DiagramShape.rect(
            34,
            _under(shelfPos(plan, left: left, k: k + 1), plan.sideH) - 5,
            76,
            5,
            label: ids.id(shelfName, k),
            tone: DiagramTone.ghost,
          ),
        DiagramShape.rect(110, 6, 14, 138, label: inner),
      ],
    );
  }

  /// A finished bar with its skins and dividers labelled.
  AssemblyDiagram barDone(Plan plan, {required bool top}) {
    final ids = PieceIds(plan);
    final b = top ? plan.topBar : plan.bottomBar;
    final long = ids.id(_longName(top));
    final short = ids.id(_shortName(top));
    final shown = math.min(b.dividers, 4);
    final xs = _spread(shown, 30, 210);
    return AssemblyDiagram(
      caption:
          'Front view of the finished ${top ? 'top' : 'bottom'} bar unit. '
          'The long panel ($long) is the outer skin and sticks out at both '
          'ends, the short panel ($short) is the inner skin, and the '
          'dividers stand between them. Not to scale.',
      width: 240,
      height: 100,
      shapes: [
        DiagramShape.rect(0, top ? 4 : 84, 240, 12, label: long),
        DiagramShape.rect(30, top ? 84 : 4, 180, 12, label: short),
        for (var k = 0; k < shown; k++)
          DiagramShape.rect(
            xs[k] - 6,
            16,
            12,
            68,
            label: ids.id(_divName(top), k),
            tone: DiagramTone.cleat,
          ),
      ],
    );
  }

  /// A side cut of the finished hang.
  AssemblyDiagram mount(Plan plan) {
    final ids = PieceIds(plan);
    final wall = ids.cleat(0, wall: true);
    final unit = ids.cleat(0, wall: false);
    return AssemblyDiagram(
      caption:
          'Side view of the unit hung on the cleat. The wall piece ($wall) '
          'is screwed to the wall and the unit piece ($unit) is on the back '
          'of the unit. Lower the unit until the two slopes lock. The unit '
          'stands about ${_f(Limits.t)} off the wall.',
      width: 170,
      height: 178,
      shapes: [
        DiagramShape.rect(0, 0, 20, 160, label: 'wall', tone: DiagramTone.wall),
        DiagramShape(
          [_p(20, 100), _p(44, 76), _p(44, 130), _p(20, 130)],
          label: wall,
          tone: DiagramTone.cleat,
        ),
        DiagramShape([
          _p(20, 100),
          _p(44, 76),
          _p(44, 30),
          _p(20, 30),
        ], label: unit),
        DiagramShape.rect(44, 10, 8, 150, tone: DiagramTone.back),
        DiagramShape.rect(
          52,
          10,
          100,
          150,
          label: 'unit',
          tone: DiagramTone.ghost,
        ),
      ],
      arrows: [_arrow(102, 20, 102, 60)],
      dimensions: [_dim(20, 170, 44, 170, _f(Limits.t))],
    );
  }
}
