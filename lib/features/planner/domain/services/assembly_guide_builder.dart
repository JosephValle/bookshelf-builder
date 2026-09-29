// ignore_for_file: no_adjacent_strings_in_list

import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:bookshelf_builder/features/planner/domain/models/assembly_step.dart';
import 'package:bookshelf_builder/features/planner/domain/models/fasteners.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_diagram_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cleat_layout.dart';
import 'package:bookshelf_builder/features/planner/domain/services/fastener_counter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/parts_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/piece_ids.dart';

/// Writes the step by step assembly guide for a plan, in the style of flat
/// pack furniture instructions: one small step per join, each with a picture,
/// the exact pieces (`A1`, `B3`), the screws and their distances from the
/// edges.
///
/// Every measurement comes from the plan, so the guide always matches the cut
/// list and the drawing. Repeated joins are written out in full on purpose,
/// so a beginner never has to guess where a piece goes.
class AssemblyGuideBuilder {
  /// Creates a builder.
  const AssemblyGuideBuilder({
    this.formatter = const InchesFormatter(),
    this.diagrams = const AssemblyDiagramBuilder(),
    this.counter = const FastenerCounter(),
    this.cleats = const CleatLayout(),
  });

  /// Inch formatting used for measurements.
  final InchesFormatter formatter;

  /// Draws the picture for each step.
  final AssemblyDiagramBuilder diagrams;

  /// Counts screws and brads.
  final FastenerCounter counter;

  /// Places the French cleat rows.
  final CleatLayout cleats;

  /// Returns the ordered steps. Steps that do not apply (toe kick, edge band,
  /// wall fit, dividers) are left out.
  List<AssemblyStep> build(Plan plan) {
    final f = formatter.format;
    final i = plan.inputs;
    final s = plan.sheets;
    final ids = PieceIds(plan);
    final dg = diagrams;
    final n = Fasteners.screwsPerJoint(plan.depthPanel);
    final steps = <AssemblyStep>[];
    void add(
      String title,
      List<String> details, [
      List<AssemblyDiagram> pictures = const [],
    ]) => steps.add(AssemblyStep(title, details, diagrams: pictures));

    String plural(int count, String word) => count == 1 ? word : '${word}s';
    final cleatW = f(Limits.anchorCleatW);
    final wallId = ids.id(PartsBuilder.wallCleatName);
    final unitId = ids.id(PartsBuilder.unitCleatName);
    const pilot =
        'Drill a pilot hole for every screw first (a 1/8" bit is typical for '
        '1-1/4" screws) so the plywood does not split.';
    final screwPlace =
        '${f(Fasteners.edgeInset)} in from the front edge and '
        '${f(Fasteners.edgeInset)} in from the back edge'
        '${n == 3 ? ', with one more halfway between' : ''}';

    // ---------------------------------------------------------------------
    // Getting ready

    add('Gather materials and tools', [
      '${s.sheets34} sheets of 3/4" sanded plywood (4x8) and about '
          '${s.backSheets} sheet of 1/4" plywood for the backs.',
      if (i.edgeStiffener)
        'Solid front edge band: ${(plan.edgeBandInches / 12).toStringAsFixed(1)} '
            'linear feet.',
      'Wood glue, 1-1/4" screws or pocket screws, 18 gauge brad nails, and '
          'construction screws for the wall.',
      'Fasteners to buy (about, plus a few spares): '
          '1-1/4" screws: ${counter.columnScrews(plan, plan.leftCol) + counter.columnScrews(plan, plan.rightCol) + counter.barScrews(plan, plan.topBar) + counter.barScrews(plan, plan.bottomBar) + counter.ringScrews(plan) + counter.toeKickScrews(plan)}. '
          '1" brad nails: ${counter.backBrads(plan)}. '
          '2" screws for the unit cleat: ${counter.unitCleatScrews(plan)}. '
          '3" screws for the wall cleat: ${counter.wallCleatScrews(plan)}.',
      'Circular saw with a straight edge guide or a table saw, drill, clamps, '
          'a large square, a level, and a stud finder.',
      'Also have a pencil, a tape measure, painter tape, sandpaper (120 and '
          '150 grit), a damp rag for wiping off glue, and two sawhorses.',
      'The cut list gives every part with its size and count. Print it or '
          'keep it open while you work.',
      if (i.openW != i.windowW || i.openH != i.windowH)
        'Your window is ${f(i.windowW)} by ${f(i.windowH)}. With trim and gaps '
            'the framed opening is ${f(i.openW)} by ${f(i.openH)}, and that is '
            'the size the shelves are built around.',
      'Read the whole guide once before cutting. Measure your window opening '
          'again and confirm it is ${f(i.windowW)} wide by ${f(i.windowH)} '
          'tall.',
    ]);

    add('Before you cut: safety and words used here', [
      'Wear safety glasses, hearing protection and a dust mask whenever you '
          'saw or sand. Plywood dust is fine and irritating.',
      'A full sheet is heavy and awkward. Ask a helper to carry it, and '
          'never cut a sheet that is hanging unsupported, because it pinches '
          'the blade.',
      'Keep your hands well away from the blade. Use a push stick on a table '
          'saw, and clamp the work down for a circular saw.',
      'Rip means to cut along the long direction of a board. Crosscut means '
          'to cut across it to a length.',
      'Kerf is the thin strip of wood the blade turns into dust. It is '
          'already allowed for in the counts in this guide.',
      'Square means two edges meet at exactly 90 degrees. Check with a '
          'framing square, and measure both diagonals of any rectangle: if '
          'they match, it is square.',
      'Flush means two surfaces line up with no step between them.',
      'The front is the edge that faces into the room. The back is the edge '
          'that goes against the wall.',
      'Pilot hole means a thin hole drilled before a screw so the wood does '
          'not split. Always drill one.',
      'Piece ids: every piece has an id such as A1. The letter says what '
          'size it is, and the number tells the copies apart. Pieces with '
          'the same letter are identical.',
      'Set aside a flat, clear area at least ${f(plan.ringW + 24)} long by '
          '${f(plan.ringH + 24)} wide. You will build the unit lying on the '
          'floor.',
    ]);

    add('Rip and cut the parts', [
      'Set the sheet on sawhorses with a sacrificial board or foam under it, '
          'so the offcut cannot drop and splinter the edge.',
      'Rip the 3/4" sheets into strips ${f(plan.depthPanel)} wide '
          '(${s.stripsPerSheet} strips per sheet, allowing for the saw kerf). '
          'Use a straight edge guide clamped to the sheet, and measure from '
          'the guide to the blade, not to the guide itself.',
      'Circular saws cut up, so put the good face down. A table saw cuts '
          'down, so put the good face up.',
      'Crosscut every part to the lengths in the cut list. Cut the longest '
          'parts first, and cut all pieces with the same letter at the same '
          'saw setting.',
      'Rip the narrow strips (toe kick, anchor cleats and the French cleat '
          'pair) from the leftover width.',
      'Cut the 1/4" back panels last, about 1/16" undersize on each edge so '
          'they never overhang.',
      'Sand the faces and ease the sharp edges of every part now with 120 '
          'then 150 grit. It is much easier before the parts are glued into '
          'boxes.',
    ]);

    add('Label every piece', [
      'Write each piece id in pencil on the inside face of the piece, near '
          'one end, as you cut it. Ids follow the cut list.',
      for (final p in plan.parts)
        if (p.material != PartMaterial.edgeBand)
          '${p.idRange}: ${p.name}, ${formatter.partLength(p)} by ${f(p.width)}.',
      'Stack the pieces by letter. Check the count against the cut list '
          'before you build anything.',
    ]);

    add(
      'Make the French cleat pair',
      [
        'A French cleat is two matching strips with sloped edges. One is '
            'screwed to the wall and one to the back of the unit. The unit '
            'hangs by its own weight and is held tight against the wall.',
        'Both strips come from the cut list: $wallId (wall half) and $unitId '
            '(unit half), each $cleatW wide and '
            '${f(counter.cleatPieceLengths(plan).fold<double>(0, (a, b) => a + b))} '
            'long in total.',
        'Cut each long strip into four pieces, one for each row on each '
            'column: ${f(i.left)}, ${f(i.left)}, ${f(i.right)} and '
            '${f(i.right)} long. Name them ${wallId}a to ${wallId}d and '
            '${unitId}a to ${unitId}d. Piece a and b are for the left column '
            '(top row, middle row) and c and d for the right column.',
        'Tilt the saw blade to 45 degrees and cut one long edge of every '
            'piece so the edge slopes through the whole 3/4" thickness.',
        'Wall pieces: the sloped edge is on top, and its sharp point sticks '
            'out into the room when the piece is on the wall.',
        'Unit pieces: the sloped edge is on the bottom, and its sharp point '
            'points toward the wall when the piece is on the back of the unit.',
        'Test ${unitId}a on ${wallId}a on a bench. The unit piece must rest on '
            'top of the wall piece with the two sloped faces touching all '
            'along their length. If they do not, re-cut.',
        'Set the pieces aside, labelled. Do not screw anything down yet.',
      ],
      [dg.cleatPair(plan)],
    );

    // ---------------------------------------------------------------------
    // Columns

    for (final left in [true, false]) {
      final side = left ? 'Left' : 'Right';
      final c = left ? plan.leftCol : plan.rightCol;
      final shelfName = left ? 'Left column shelf' : 'Right column shelf';
      final divName = left ? 'Left column divider' : 'Right column divider';
      final outer = ids.id('Outer column panel', left ? 0 : 1);
      final inner = ids.id('Inner column panel', left ? 0 : 1);
      final colW = left ? i.left : i.right;

      add(
        '$side column: mark the shelf lines on $outer and $inner',
        [
          'The ${side.toLowerCase()} column is ${f(colW)} wide overall: $outer (outer panel) '
              'and $inner (inner panel), each ${f(plan.sideH)} long, with '
              '${f(c.clearW)} clear between them.',
          if (c.shelves > 0) ...[
            'Lay $outer and $inner side by side on the floor, inside faces up, '
                'with their bottom ends level. Clamp them together so the marks '
                'match.',
            'Mark ${c.shelves} shelf ${plural(c.shelves, 'line')}. Measure up '
                'from the bottom end. The first line is ${f(c.clearH)} up. '
                'Every next line is ${f(c.clearH + Limits.t)} above the last.',
            'Each line is the underside of a shelf. Draw the line across both '
                'panels with a square, then draw a second line ${f(Limits.t)} '
                'above it so you can see which side the shelf goes on.',
            'Unclamp the panels. Put $inner aside for now.',
          ] else
            'No fixed shelves are needed for this height, so there is nothing '
                'to mark. Put $inner aside.',
        ],
        [if (c.shelves > 0) dg.columnMarks(plan, left: left)],
      );

      for (var k = 0; k < c.shelves; k++) {
        final shelf = ids.id(shelfName, k);
        final pos = dg.shelfPos(plan, left: left, k: k + 1);
        add(
          '$side column: attach shelf $shelf to $outer',
          [
            k == 0
                ? 'Rest $outer flat on two 2x4 blocks, inside face up, with '
                      'its bottom end toward your feet and its front edge '
                      'toward you. The blocks keep its underside reachable '
                      'for the drill.'
                : '$outer stays flat on the blocks, inside face up. Shelves '
                      'placed already: ${[for (var j = 0; j < k; j++) ids.id(shelfName, j)].join(', ')}.',
            'Put a bead of glue on the end of $shelf.',
            'Stand $shelf on its end on line ${k + 1}, with its underside on '
                'the line (${f(pos)} up from the bottom end of $outer) and its '
                'end against $outer. Hold it upright with a clamped scrap '
                'block on each side, or ask a helper.',
            'Its front edge must be level with the front edge of $outer. '
                'Check the corner with the square: $shelf and $outer must meet '
                'at 90 degrees.',
            'From underneath, drive $n screws up through $outer into the end '
                'of $shelf: $screwPlace. They go through the middle of the '
                'shelf thickness, ${f(Limits.t / 2)} from either face of it.',
            pilot,
            'Wipe off glue that squeezes out with a damp rag.',
          ],
          [
            dg.columnShelf(plan, left: left, k: k),
            dg.shelfScrews(
              plan,
              panelId: outer,
              bandId: shelf,
              bandName: 'shelf',
            ),
          ],
        );
      }

      if (c.dividers > 0) {
        for (var r = 0; r <= c.shelves; r++) {
          for (var j = 0; j < c.dividers; j++) {
            final div = ids.id(divName, r * c.dividers + j);
            final below = r == 0
                ? 'the bottom panel'
                : ids.id(shelfName, r - 1);
            final above = r == c.shelves
                ? 'the top panel'
                : ids.id(shelfName, r);
            final m = j + 1;
            final dist = m * c.bayW + (m - 1) * Limits.t;
            add(
              '$side column: attach divider $div in opening ${r + 1}',
              [
                'Opening ${r + 1} is between $below (below) and $above '
                    '(above).',
                'Stand $div on its end in the opening with its left face '
                    '${f(dist)} from the inside face of $outer. Its front edge '
                    'is level with the front edges of the shelves.',
                'Check it with the square.',
                if (r == c.shelves)
                  'The top end is held later by the top panel.'
                else
                  'Drive $n screws through $above into the top end of $div: '
                      '$screwPlace.',
                if (r > 0)
                  'Then drive $n screws through $below into the bottom end of '
                      '$div in the same places.'
                else
                  'The bottom end is held later by the bottom panel.',
                pilot,
                'If the drill will not fit sideways in the opening, use '
                    'pocket screws, or hold the divider with glue and a clamp '
                    'until the top and bottom panels lock it later.',
              ],
              [
                dg.columnDivider(plan, left: left, opening: r, index: j),
                dg.shelfScrews(
                  plan,
                  panelId: r == c.shelves ? 'the top panel' : above,
                  bandId: div,
                  bandName: 'divider',
                ),
              ],
            );
          }
        }
      }

      add(
        '$side column: attach $inner on top of the shelves',
        [
          'Put glue on the free end of every shelf ($side column shelves).',
          'Lay $inner on the shelf ends with its bottom end level with the '
              'bottom end of $outer and its front edge level with the front '
              'edges of the shelves. Line up its shelf marks with the shelf '
              'ends.',
          'Clamp it, then drive $n screws through $inner into the end of every '
              'shelf: $screwPlace, in the middle of the shelf thickness.',
          pilot,
          'Wipe off squeezed-out glue.',
        ],
        [
          if (c.shelves > 0) dg.columnInner(plan, left: left),
          if (c.shelves > 0)
            dg.shelfScrews(
              plan,
              panelId: inner,
              bandId: ids.id(shelfName, 0),
              bandName: 'shelf',
            ),
        ],
      );

      add(
        '$side column: check it is square',
        [
          'Measure both diagonals of the column. They must match within 1/16".',
          'If they differ, push the long corners together with a clamp until '
              'they match, and leave it clamped until the glue has set.',
          'Set the column aside on its edge, out of the way. Leave the glue '
              'to cure for at least an hour.',
        ],
        [dg.squareCheck(plan, w: colW, h: plan.sideH, what: 'the column')],
      );
    }

    // ---------------------------------------------------------------------
    // Bars

    for (final top in [true, false]) {
      final b = top ? plan.topBar : plan.bottomBar;
      final which = top ? 'Top' : 'Bottom';
      final longName = top ? 'Top panel' : 'Bottom panel';
      final shortName = top ? 'Head panel' : 'Sill panel';
      final divName = top ? 'Top bar divider' : 'Bottom bar divider';
      final shelfName = top ? 'Top bar shelf' : 'Bottom bar shelf';
      final long = ids.id(longName);
      final short = ids.id(shortName);
      final hasCleat = top || !i.onFloor;
      final cleatName = top
          ? PartsBuilder.topCleatName
          : PartsBuilder.bottomCleatName;
      final cleat = ids.id(cleatName);

      add(
        '$which bar: mark the divider lines on $long',
        [
          'The $which bar is a hollow box that spans '
              '${top ? 'above' : 'below'} the window. The long '
              '${top ? 'top' : 'bottom'} panel ($long) is its outer skin and '
              '${top ? 'the head' : 'the sill'} panel ($short) is its inner '
              'skin.',
          'Rest $long flat on 2x4 blocks with its inside face up (the face '
              'that will look into the bar) and its front edge toward you. '
              'The blocks keep its underside reachable for the drill. It is '
              '${f(plan.ringW)} long, so it sticks out past the bar '
              'by ${f(i.left)} on the left and ${f(i.right)} on the right. '
              'That is where the columns go.',
          'Measure ${f(i.left)} from the left end and draw a line across. '
              'That is the left end of the bar. Measure ${f(i.left + i.openW)} '
              'from the left end for the right end.',
          if (b.dividers > 0) ...[
            for (var m = 1; m <= b.dividers; m++)
              'Line $m (divider ${ids.id(divName, m - 1)}): '
                  '${f(dividerPos(plan, top, m))} from the left end of $long. '
                  'Draw a second line ${f(Limits.t)} to the right of it so you '
                  'can see which side the divider goes on.',
            'The gaps between dividers are ${f(b.bayW)} clear.',
          ] else
            'No dividers are needed for this width.',
        ],
        [dg.barMarks(plan, top: top)],
      );

      if (b.dividers > 0 && hasCleat) {
        add(
          '$which bar: notch the dividers for the anchor cleat',
          [
            'Take all ${b.dividers} ${plural(b.dividers, 'divider')} '
                '(${ids.ids(divName).first}'
                '${b.dividers > 1 ? ' to ${ids.ids(divName).last}' : ''}), each '
                '${f(b.dividerLength)} long.',
            'Cut a notch ${f(Limits.t)} deep and ${f(Limits.anchorCleatW)} tall '
                'out of the back ${top ? 'top' : 'bottom'} corner of every '
                'divider. The back is the edge that will face the wall.',
            'Use a jig saw or a hand saw, then square the corner with a chisel '
                'or sandpaper. Stack the dividers to check they match.',
          ],
          [dg.barNotch(plan, top: top)],
        );
      }

      for (var k = 0; k < b.dividers; k++) {
        final div = ids.id(divName, k);
        final m = k + 1;
        add(
          '$which bar: attach divider $div to $long',
          [
            'Put glue on the ${top ? 'top' : 'bottom'} end of $div.',
            'Stand it on its end on line $m, ${f(dividerPos(plan, top, m))} '
                'from the left end of $long, on the side of the line you '
                'marked. If it has a notch, the notch is at the back. Hold it '
                'upright with a clamped scrap block on each side.',
            'Its front edge is level with the front edge of $long. Square it '
                'to the panel.',
            'From underneath, drive $n screws up through $long into the end '
                'of $div: $screwPlace.',
            pilot,
          ],
          [dg.barDivider(plan, top: top, k: k)],
        );
      }

      if (hasCleat) {
        add(
          '$which bar: glue in the anchor cleat $cleat',
          [
            '$cleat is ${f(i.openW)} long, $cleatW tall and ${f(Limits.t)} '
                'thick. Its ends are level with the ends of the bar.',
            'Put glue in the notches and along the back edge of $long, then '
                'stand $cleat on edge in the notches with its back face level '
                'with the back edge of $long and the back edges of the '
                'dividers.',
            if (b.dividers > 0)
              'Drive 2 screws through $cleat into every divider: one '
                  '${f(Fasteners.wallScrewEdgeInset)} from the top edge of the '
                  'cleat and one ${f(Fasteners.wallScrewEdgeInset)} from the '
                  'bottom edge. This is where the wall anchors bite, so make '
                  'it solid.',
            pilot,
          ],
          [dg.barCleat(plan, top: top)],
        );
      }

      if (b.tiers == 2) {
        for (var k = 0; k <= b.dividers; k++) {
          final shelf = ids.id(shelfName, k);
          add(
            '$which bar: fit shelf $shelf in bay ${k + 1}',
            [
              'Lay $shelf in bay ${k + 1}, level with the middle of the bar '
                  'height and level with the front edges.',
              'Drive $n screws through the divider on each side into the ends '
                  'of $shelf, $screwPlace.',
              pilot,
            ],
            [dg.barShelf(plan, top: top, k: k)],
          );
        }
      }

      add(
        '$which bar: attach ${top ? 'the head' : 'the sill'} panel $short',
        [
          'Put glue on the free ${top ? 'top' : 'bottom'} edges of every '
              'divider${hasCleat ? ' and of the anchor cleat' : ''}.',
          'Lay $short on the dividers. It is ${f(i.openW)} long, so it stops '
              '${f(i.left)} short of the left end of $long, with its edges '
              'level with the bar ends and with the front edges.',
          if (b.dividers > 0)
            'Drive $n screws down through $short into every divider, '
                '$screwPlace.',
          'Measure both diagonals of the bar box. They must match within 1/16".',
          pilot,
        ],
        [dg.barSkin(plan, top: top)],
      );
    }

    // ---------------------------------------------------------------------
    // Ring

    final topLong = ids.id('Top panel');
    final bottomLong = ids.id('Bottom panel');
    add(
      'Ring: lay the top bar unit down',
      [
        'Work with a helper. You will build the ring lying on its back on the '
            'floor, so every panel stands on its back edge.',
        'Lay the top bar unit ($topLong with its bar) on the floor with the '
            'back edge down and the outside face of $topLong facing the wall '
            'end of your work area. Clamp it so it cannot roll.',
      ],
      [dg.ringStage(plan, stage: 0)],
    );

    for (final left in [true, false]) {
      final side = left ? 'left' : 'right';
      final c = left ? plan.leftCol : plan.rightCol;
      final outer = ids.id('Outer column panel', left ? 0 : 1);
      final inner = ids.id('Inner column panel', left ? 0 : 1);
      final inset = f(left ? i.left - Limits.t : i.right - Limits.t);
      add(
        'Ring: attach the $side column to $topLong',
        [
          'Put glue on the top ends of $outer and $inner.',
          'Stand the $side column on its back edge, with its top end against '
              'the inside face of $topLong. $outer is level with the '
              '$side end of $topLong, and $inner is $inset in from that end, '
              'on the bar side.',
          'The front edges of the column and of $topLong are level. Check the '
              'corner with the square.',
          'Drive $n screws through $topLong into the end of $outer and $n '
              'into the end of $inner: $screwPlace.',
          if (c.dividers > 0)
            'The ${c.dividers} ${plural(c.dividers, 'divider')} in the top '
                'opening also need $n screws each through $topLong, in line '
                'with them.',
          pilot,
        ],
        [
          dg.ringStage(plan, stage: left ? 1 : 2),
          dg.ringColumn(plan, left: left, top: true),
        ],
      );
    }

    for (final left in [true, false]) {
      final side = left ? 'left' : 'right';
      final inner = ids.id('Inner column panel', left ? 0 : 1);
      final head = ids.id('Head panel');
      add(
        'Ring: screw $inner into the end of the head panel $head',
        [
          'Push $inner tight against the end of $head (the head panel of the '
              'top bar).',
          'Drive $n screws through $inner into the end of $head: '
              '$screwPlace, in the middle of its thickness.',
          pilot,
          'This ties the $side column to the top bar.',
        ],
        [dg.barEnd(plan, left: left, top: true)],
      );
    }

    add(
      'Ring: slide the bottom bar unit onto the columns',
      [
        'Put glue on the bottom ends of both columns.',
        'Slide the bottom bar unit ($bottomLong with its bar) up onto them, '
            'with its inside face against the column ends, its front edge '
            'level with the front edges, and the bar between the inner '
            'panels.',
        'Check the gap between the head panel and the sill panel is exactly '
            '${f(i.openH)}. That is the window opening.',
      ],
      [dg.ringStage(plan, stage: 3)],
    );

    for (final left in [true, false]) {
      final side = left ? 'left' : 'right';
      final c = left ? plan.leftCol : plan.rightCol;
      final outer = ids.id('Outer column panel', left ? 0 : 1);
      final inner = ids.id('Inner column panel', left ? 0 : 1);
      add(
        'Ring: attach the $side column to $bottomLong',
        [
          'Drive $n screws through $bottomLong into the end of $outer and $n '
              'into the end of $inner: $screwPlace.',
          if (c.dividers > 0)
            'The ${c.dividers} ${plural(c.dividers, 'divider')} in the bottom '
                'opening also need $n screws each through $bottomLong.',
          pilot,
        ],
        [dg.ringColumn(plan, left: left, top: false)],
      );
    }

    for (final left in [true, false]) {
      final inner = ids.id('Inner column panel', left ? 0 : 1);
      final sill = ids.id('Sill panel');
      add(
        'Ring: screw $inner into the end of the sill panel $sill',
        [
          'Drive $n screws through $inner into the end of $sill: '
              '$screwPlace, in the middle of its thickness.',
          pilot,
        ],
        [dg.barEnd(plan, left: left, top: false)],
      );
    }

    add(
      'Ring: check it is square and the opening is right',
      [
        'Measure the ring: it is ${f(plan.ringW)} wide by ${f(plan.ringH)} '
            'tall. Measure both diagonals across the whole ring. They must '
            'match within 1/16".',
        'Check the framed opening is ${f(i.openW)} by ${f(i.openH)}. Measure '
            'diagonals across the window opening too.',
        'Clamp the ring square and leave the glue to cure for at least an '
            'hour before you move it.',
      ],
      [
        dg.squareCheck(
          plan,
          w: plan.ringW,
          h: plan.ringH,
          what: 'the whole ring',
        ),
      ],
    );

    if (i.edgeStiffener) {
      add('Add the front edge band', [
        'With the ring still on its back, the front edges point up.',
        'Glue and nail solid edge band to the front of every horizontal '
            'panel: ${(plan.edgeBandInches / 12).toStringAsFixed(1)} linear '
            'feet in total.',
        'This stiffens the shelves and is what allows the ${f(plan.spanLimit)} '
            'span limit.',
        'Sand the band flush with the panel faces once the glue has dried.',
      ]);
    }

    if (i.onFloor) {
      final kick = ids.id(PartsBuilder.toeKickName);
      add(
        'Build the toe kick',
        [
          '$kick is ${f(plan.ringW)} long and ${f(i.toeKick)} tall.',
          'Glue and screw blocks cut from offcuts to the underside of '
              '$bottomLong, set back from the front edge to where you want the '
              'kick.',
          'Screw $kick to the blocks about every '
              '${f(Fasteners.toeKickSpacing)}. Slide shims under it later if '
              'the floor is uneven.',
          'Check it is level along its full length before moving on.',
        ],
        [dg.toeKick(plan)],
      );
    }

    // ---------------------------------------------------------------------
    // Backs

    add('Flip the unit onto its front', [
      'With a helper, turn the ring over so the front edges are on the floor '
          'and the open backs face up.',
      'Keep it on a flat floor while you work on the backs.',
    ]);

    const backNames = [
      'Back panel, left column',
      'Back panel, right column',
      'Back panel, top bar',
      'Back panel, bottom bar',
    ];
    const backWhere = [
      'the left column',
      'the right column',
      'the top bar',
      'the bottom bar',
    ];
    for (var k = 0; k < 4; k++) {
      final id = ids.id(backNames[k]);
      add(
        'Back panel $id: nail it on ${backWhere[k]}',
        [
          'Put glue on the back edges of every panel, shelf and divider that '
              '$id covers.',
          'Lay $id on ${backWhere[k]}, flush with its outer edges. It is cut '
              '1/16" small on each edge so it never overhangs.',
          'Nail with 1" brads ${f(Fasteners.nailInset)} in from every edge and '
              'no more than ${f(Fasteners.nailSpacing)} apart. Also nail into '
              'every shelf and divider behind it at the same spacing.',
          'Check the corners are still square as you nail. The back panels '
              'lock the shape in place.',
        ],
        [dg.backs(plan, current: k), dg.nails(plan, backId: id)],
      );
    }

    // ---------------------------------------------------------------------
    // French cleat, unit half

    const rowLabel = ['top row', 'middle row'];
    for (var k = 0; k < 4; k++) {
      final left = k < 2;
      final row = k % 2;
      final unit = '$unitId${'abcd'[k]}';
      final shelfNo = cleats.shelfFor(plan, row);
      final bottom = cleats.bottomEdge(plan, row);
      const shelfName = 'Left column shelf';
      add(
        'French cleat: fasten unit piece $unit to the ${left ? 'left' : 'right'} column',
        [
          'Leave the unit face down with the back facing up.',
          if (shelfNo != null)
            'This is the ${rowLabel[row]}. Center $unit on ${left ? ids.id(shelfName, shelfNo - 1) : 'the shelf level with it'}, '
                'so the screws bite the shelf edge behind the 1/4" back. The '
                'bottom edge of $unit is ${f(bottom)} above the bottom of the '
                'unit, measured on the face that touches the back panel.'
          else if (row == 0)
            'This is the ${rowLabel[row]}. With no shelf to center on, put the '
                'top edge of $unit level with the top of the unit, and run the '
                'screws along it ${f(Limits.t / 2)} below the top edge, into '
                'the edge of the top panel.'
          else
            'This is the ${rowLabel[row]}. With no shelf to center on, put the '
                'bottom edge of $unit level with the bottom of the unit and '
                'screw along it into the edge of the bottom panel.',
          'Its ends are level with the outside of the column: it is '
              '${f(left ? i.left : i.right)} long. The sloped edge is on the '
              'bottom, and its sharp point faces the wall.',
          'The same row on the ${left ? 'right' : 'left'} column must be at '
              'the same height above the bottom of the unit.',
          'Spread glue on the back of $unit. Drive 2" screws through it and '
              'the 1/4" back into the shelf or panel edge: ${f(Fasteners.cleatEndInset)} from each end, '
              'then one at least every ${f(Fasteners.screwSpacing)} along the '
              'middle of the strip.',
          pilot,
        ],
        [
          dg.unitCleat(plan, current: k),
          dg.cleatScrews(plan, wall: false, piece: k),
        ],
      );
    }

    // ---------------------------------------------------------------------
    // Wall

    final floorGap = cleats.unitBottomAboveFloor(plan);
    add('Mount: find the studs and mark the heights', [
      'Find the studs (usually every ${f(Limits.studSpacing)} on center) and '
          'mark them with painter tape. Confirm each one by probing with a '
          'thin nail in a spot that will be hidden.',
      if (i.wallW != null)
        'On your wall the window sits ${f(i.windowLeftOnWall ?? 0)} from the '
            'left edge, with a ${f(plan.inputs.left)} left column and a '
            '${f(plan.inputs.right)} right column.',
      floorGap != null
          ? 'The bottom of the unit is ${f(floorGap)} above the floor.'
          : 'Decide how high the bottom of the unit will be above the floor '
                'and measure it. Call this the floor height.',
      for (var row = 0; row < CleatLayout.rows; row++)
        'The ${rowLabel[row]} wall pieces go with their sharp top edge '
            '${floorGap != null ? f(floorGap + cleats.bottomEdge(plan, row)) : '${f(cleats.bottomEdge(plan, row))} plus the floor height'} '
            'above the floor. Draw a level line at that height.',
      'The two rows must be level and the same height on both columns.',
      'The far ends of the left and right pieces are ${f(plan.ringW)} apart. '
          'Mark where the unit will start and end.',
      'Each row of cleat must cross at least one stud. If a column is '
          'narrower than the stud spacing it may not, so use hollow wall '
          'anchors rated for the load in that case.',
    ]);

    for (var k = 0; k < 4; k++) {
      final left = k < 2;
      final row = k % 2;
      final wall = '$wallId${'abcd'[k]}';
      final height = floorGap != null
          ? f(floorGap + cleats.bottomEdge(plan, row))
          : '${f(cleats.bottomEdge(plan, row))} plus the floor height';
      add(
        'Mount: screw wall piece $wall to the wall',
        [
          'This is the ${rowLabel[row]} on the ${left ? 'left' : 'right'} '
              'column. It is ${f(left ? i.left : i.right)} long.',
          'Hold it on the level line with its sloped edge on top and its sharp '
              'point sticking out from the wall. Its top edge is $height above '
              'the floor.',
          'Drive 3" screws through it into every stud it crosses: two per '
              'stud, one ${f(Fasteners.wallScrewEdgeInset)} below the top edge '
              'and one ${f(Fasteners.wallScrewEdgeInset)} above the bottom '
              'edge.',
          'Check it with the level before the next piece.',
        ],
        [dg.cleatScrews(plan, wall: true, piece: k)],
      );
    }

    add(
      'Mount: hang the unit',
      [
        'Get at least one helper. Lift the unit with the back toward the wall.',
        'Set each unit piece just above its wall piece, then lower the unit '
            'until the two slopes lock. It should sit firmly with no wobble '
            'and about ${f(Limits.t)} off the wall.',
        'Drive the anchors for the bar above the window through its solid '
            'anchor cleat, never through the 1/4" back alone. Put a scrap of '
            '3/4" plywood between the bar and the wall at each screw so it '
            'does not pull the back out of shape.',
        'Level the unit, then anchor it against tipping.',
      ],
      [dg.mount(plan)],
    );

    add('Finish and check', [
      'Fill nail holes, sand to 150 grit, and finish as you like.',
      'Wipe off dust before you paint or stain, and let the finish cure '
          'before you load the shelves.',
      if (plan.issues.isNotEmpty)
        'Review the warnings listed in this document before you build.',
      'Load the heaviest books low and at the columns first, and check '
          'the unit for movement.',
      'These limits are rules of thumb. Verify them against your actual '
          'book load.',
    ]);
    return steps;
  }

  /// Distance from the left end of the long panel to the left face of divider
  /// [m] (one based) of a bar.
  double dividerPos(Plan plan, bool top, int m) =>
      diagrams.dividerPos(plan, top: top, m: m);
}
