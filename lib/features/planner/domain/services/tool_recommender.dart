import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/tool_recommendation.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';

/// Recommends the tools and supplies to build a plan.
///
/// The list adapts to the plan: cutting tools scale with the number of sheets,
/// edge band and wall fitting add their own items, and very tall units call for
/// a helper.
class ToolRecommender {
  /// Creates a recommender.
  const ToolRecommender({this.formatter = const InchesFormatter()});

  /// Inch formatting used in the explanations.
  final InchesFormatter formatter;

  /// Returns the recommendations, essential items first.
  List<ToolRecommendation> recommend(Plan plan) {
    final f = formatter.format;
    final i = plan.inputs;
    final sheets = plan.sheets.sheets34 + plan.sheets.backSheets;
    final rips = plan.sheets.neededStrips;
    final tall = plan.ringH > 84;
    final clampCount = plan.ringW > 96 || plan.ringH > 84 ? 8 : 6;
    final items = <ToolRecommendation>[
      ToolRecommendation(
        name: 'Track saw, or circular saw with a straight edge guide',
        reason:
            'Breaks down $sheets sheet${sheets == 1 ? '' : 's'} into '
            '$rips rips of ${f(plan.depthPanel)}. A table saw also works, '
            'but full sheets are easier to handle with a guided saw.',
      ),
      const ToolRecommendation(
        name: 'Miter saw or crosscut guide',
        reason: 'Cuts the ripped strips to exact length, square every time.',
      ),
      const ToolRecommendation(
        name: 'Cordless drill/driver with a countersink bit',
        reason: 'Drives the screws that hold the shelves and dividers.',
      ),
      ToolRecommendation(
        name: '$clampCount bar or parallel clamps',
        reason:
            'Holds the glue joints square while they dry. A ${f(plan.ringW)} '
            'wide ring needs clamps long enough to reach across the columns.',
      ),
      const ToolRecommendation(
        name: 'Framing square and tape measure',
        reason: 'Checks every shelf for square and every part for length.',
      ),
      const ToolRecommendation(
        name: 'Wood glue and 1-1/4" screws',
        reason: 'Glued and screwed joints keep the box beams stiff.',
      ),
      const ToolRecommendation(
        name: '18 gauge brad nailer with 1" brads',
        reason:
            'Fastens the 1/4" back panels, which stiffen the whole unit, and '
            'edge band.',
      ),
      const ToolRecommendation(
        name: 'Safety glasses, hearing protection and a dust mask',
        reason: 'Sawing and sanding plywood makes fine dust and noise.',
      ),
      const ToolRecommendation(
        name: '4 ft level',
        reason: 'Sets the unit plumb and level when you mount it.',
      ),
      if (i.concreteWall) ...[
        const ToolRecommendation(
          name: 'Hammer drill with masonry bits',
          reason:
              'Drills the holes in concrete or block for the French cleat '
              'and the anti-tip anchors. A 5/32" carbide bit suits 3/16" '
              'concrete screws.',
        ),
        const ToolRecommendation(
          name: 'Blow-out bulb or a vacuum',
          reason: 'Clears the dust from each hole so the screw grips.',
        ),
        const ToolRecommendation(
          name: 'Concrete screws (3/16" x 2-1/4") and anti-tip straps',
          reason:
              'Fasten the wall half of the cleat, and anchor the unit through '
              'the solid anchor cleat, not the 1/4" back alone.',
        ),
      ] else ...[
        ToolRecommendation(
          name: 'Stud finder',
          reason:
              'Locates studs every ${f(i.studSpacing)} for the French '
              'cleat and the anti-tip anchors.',
        ),
        const ToolRecommendation(
          name: 'Structural screws (about 3") and anti-tip straps',
          reason:
              'Anchors the unit to the wall through the solid anchor cleat, '
              'not the 1/4" back alone.',
        ),
      ],
      if (tall)
        ToolRecommendation(
          name: 'A helper and a sturdy step stool',
          reason:
              'At ${f(plan.ringH)} tall the assembled unit is awkward and '
              'heavy for one person to stand up and mount.',
        ),
      if (i.onFloor)
        const ToolRecommendation(
          name: 'Shims',
          reason: 'Levels the toe kick on an uneven floor before mounting.',
        ),
      if (i.edgeStiffener)
        const ToolRecommendation(
          name: 'Table saw or router table for edge band strips',
          reason:
              'Rips the 3/4" edge band strips from plywood so the shelves '
              'can span the longer stiffened limit.',
          essential: false,
        ),
      const ToolRecommendation(
        name: 'Pocket hole jig',
        reason: 'An alternative way to join shelves without visible screws.',
        essential: false,
      ),
      const ToolRecommendation(
        name: 'Random orbit sander and 150 grit paper',
        reason: 'Smooths edges and prepares the plywood for finish.',
        essential: false,
      ),
      const ToolRecommendation(
        name: 'Roundover router bit',
        reason: 'Softens the exposed plywood edges before finishing.',
        essential: false,
      ),
    ];
    final essential = items.where((t) => t.essential);
    final optional = items.where((t) => !t.essential);
    return [...essential, ...optional];
  }
}
