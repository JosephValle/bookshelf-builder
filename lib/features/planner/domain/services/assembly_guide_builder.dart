// ignore_for_file: no_adjacent_strings_in_list

import 'package:bookshelf_builder/features/planner/domain/models/assembly_step.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';

/// Writes the step by step assembly guide for a plan.
///
/// Every measurement comes from the plan, so the guide always matches the cut
/// list and the drawing.
class AssemblyGuideBuilder {
  /// Creates a builder.
  const AssemblyGuideBuilder({this.formatter = const InchesFormatter()});

  /// Inch formatting used for measurements.
  final InchesFormatter formatter;

  /// Returns the ordered steps. Steps that do not apply (toe kick, edge band,
  /// wall fit, dividers) are left out.
  List<AssemblyStep> build(Plan plan) {
    final f = formatter.format;
    final i = plan.inputs;
    final s = plan.sheets;
    final steps = <AssemblyStep>[];
    void add(String title, List<String> details) =>
        steps.add(AssemblyStep(title, details));

    add('Gather materials and tools', [
      '${s.sheets34} sheets of 3/4" sanded plywood (4x8) and about '
          '${s.backSheets} sheet of 1/4" plywood for the backs.',
      if (i.edgeStiffener)
        'Solid front edge band: ${(plan.edgeBandInches / 12).toStringAsFixed(1)} '
            'linear feet.',
      'Wood glue, 1-1/4" screws or pocket screws, 18 gauge brad nails, and '
          'construction screws for the wall.',
      'Circular saw with a straight edge guide or a table saw, drill, clamps, '
          'a large square, a level, and a stud finder.',
      'Read the whole guide once before cutting. Measure your window opening '
          'again and confirm it is ${f(i.windowW)} wide by ${f(i.windowH)} '
          'tall.',
    ]);

    add('Rip and cut the parts', [
      'Rip the 3/4" sheets into strips ${f(plan.depthPanel)} wide '
          '(${s.stripsPerSheet} strips per sheet, allowing for the saw kerf).',
      'Crosscut every part to the lengths in the cut list. Cut the longest '
          'parts first, and label each part in pencil with its name.',
      'Rip the narrow strips (toe kick and anchor cleats) from the leftover '
          'width.',
      'Cut the 1/4" back panels last, about 1/16" undersize on each edge so '
          'they never overhang.',
    ]);

    if (i.onFloor) {
      add('Build the toe kick', [
        'The toe kick is ${f(plan.ringW)} long and ${f(i.toeKick)} tall.',
        'Set it back from the front if you want a recessed kick, and fasten '
            'it to blocking or cleats glued to the bottom panel.',
        'Check it is level along its full length before moving on.',
      ]);
    }

    for (final side in [
      ('left', plan.leftCol, i.left),
      ('right', plan.rightCol, i.right),
    ]) {
      final c = side.$2;
      add('Build the ${side.$1} column', [
        'Overall width ${f(side.$3)}: an outer panel and an inner panel, each '
            '${f(plan.sideH)} long, with ${f(c.clearW)} clear between them.',
        if (c.shelves > 0)
          'Mark ${c.shelves} shelf positions with ${f(c.clearH)} clear '
              'openings between shelves (${f(c.clearH + Limits.t)} from the '
              'top of one shelf to the top of the next).'
        else
          'No fixed shelves are needed for this height.',
        if (c.dividers > 0)
          'Each opening is wider than the shelf width limit, so add '
              '${c.dividers} vertical divider${c.dividers == 1 ? '' : 's'} '
              'per opening for bays ${f(c.bayW)} wide.',
        'Lay the panels flat, glue and screw every shelf, checking each '
            'shelf with a square before the glue sets.',
        'Measure the diagonals. They must match within 1/16".',
      ]);
    }

    add('Build the top bar (box beam)', [
      'Glue and screw the head panel and the top panel to the '
          '${plan.topBar.dividers} divider${plan.topBar.dividers == 1 ? '' : 's'} '
          'of ${f(plan.topBar.dividerLength)} to form a box ${f(i.windowW)} long.',
      'Space the dividers evenly for bays ${f(plan.topBar.bayW)} wide.',
      'Glue the solid anchor cleat inside the bar against the back edge, '
          'full width, and glue and screw it to every divider. This is where '
          'the wall anchors will bite.',
      if (plan.topBar.tiers == 2)
        'Add one horizontal shelf per bay in the middle of the bar.',
      'Glue the 1/4" back panel on to keep the beam square. Do not skip '
          'this: it stiffens the beam.',
    ]);

    add('Build the bottom bar', [
      'Glue and screw the sill panel and the bottom panel to the '
          '${plan.bottomBar.dividers} divider${plan.bottomBar.dividers == 1 ? '' : 's'} '
          'of ${f(plan.bottomBar.dividerLength)}.',
      'Space the dividers evenly for bays ${f(plan.bottomBar.bayW)} wide.',
      if (!i.onFloor)
        'This bar is not resting on the floor, so build it as a box beam '
            'with the second anchor cleat and plan how it is supported.',
      if (plan.bottomBar.tiers == 2)
        'Add one horizontal shelf per bay in the middle of the bar.',
    ]);

    add('Assemble the ring', [
      if (i.onFloor)
        'Stand the columns on the toe kick and set the bottom bar between '
            'them, then the top bar.'
      else
        'Stand the columns and set the bottom and top bars between them.',
      'Glue and screw through the column panels into the ends of the bars. '
          'Clamp until the glue sets.',
      'Check the window opening is ${f(i.windowW)} by ${f(i.windowH)} and '
          'the ring is ${f(plan.ringW)} wide by ${f(plan.ringH)} tall. '
          'Measure diagonals across the whole ring and across the window '
          'opening.',
    ]);

    add('Attach the back panels', [
      'Glue and brad nail the four 1/4" backs (left column, right column, '
          'top bar and bottom bar) flush to the edges.',
      'Nail every 6 inches along all edges and into every shelf and divider.',
    ]);

    if (i.edgeStiffener) {
      add('Add the front edge band', [
        'Glue and nail solid edge band to the front of every horizontal '
            'panel: ${(plan.edgeBandInches / 12).toStringAsFixed(1)} linear '
            'feet in total.',
        'This stiffens the shelves and is what allows the ${f(plan.spanLimit)} '
            'span limit.',
      ]);
    }

    add('Mount to the wall', [
      'Find the studs (usually every ${f(Limits.studSpacing)} on center) and '
          'mark them.',
      'Screw a continuous 3/4" plywood French cleat into the studs at the top '
          'and at mid-height on each column.',
      'Drive the anchors for the bar above the window through its solid '
          'anchor cleat, never through the 1/4" back alone.',
      if (i.wallW != null)
        'On your wall the window sits ${f(i.windowLeftOnWall ?? 0)} from the '
            'left edge, with a ${f(plan.inputs.left)} left column and a '
            '${f(plan.inputs.right)} right column.',
      'Level the unit, then anchor it against tipping.',
    ]);

    add('Finish and check', [
      'Fill nail holes, sand to 150 grit, and finish as you like.',
      if (plan.issues.isNotEmpty)
        'Review the warnings listed in this document before you build.',
      'These limits are rules of thumb. Verify them against your actual '
          'book load.',
    ]);
    return steps;
  }
}
