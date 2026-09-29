import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/cost_view.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/key_value_row.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_card.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/supplies_cost_view.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/tools_view.dart';
import 'package:flutter/material.dart';

/// The materials list as a stack of cards: plywood, estimated cost,
/// recommended tools, buying notes and wall attachment.
class MaterialsView extends StatelessWidget {
  /// Creates the view for [plan].
  const MaterialsView({required this.plan, super.key});

  /// Plan to summarize.
  final Plan plan;

  static String _sheets(int n) => '$n sheet${n == 1 ? '' : 's'}';

  @override
  Widget build(BuildContext context) {
    const f = InchesFormatter();
    final s = plan.sheets;
    return ListView(
      padding: const EdgeInsets.all(Space.md),
      children: [
        SectionCard(
          title: 'Plywood',
          icon: Icons.layers_outlined,
          child: Column(
            children: [
              KeyValueRow(
                label: '3/4" plywood',
                caption:
                    '${s.neededStrips} strips of ${f.format(plan.depthPanel)}, '
                    '${s.stripsPerSheet} per 4x8 sheet',
                value: _sheets(s.sheets34),
              ),
              KeyValueRow(
                label: '1/4" plywood',
                caption: 'Back panels, approximate',
                value: _sheets(s.backSheets),
              ),
              if (plan.inputs.edgeStiffener)
                KeyValueRow(
                  label: 'Front edge band',
                  caption: 'Solid strips on every horizontal front edge',
                  value:
                      '${(plan.edgeBandInches / 12).toStringAsFixed(1)} '
                      'linear feet',
                ),
            ],
          ),
        ),
        CostView(plan: plan),
        SuppliesCostView(plan: plan),
        ToolsView(plan: plan),
        const SectionCard(
          title: 'Buying',
          icon: Icons.storefront_outlined,
          child: Text(PlannerNotes.store),
        ),
        SectionCard(
          title: 'Wall attachment',
          icon: Icons.home_outlined,
          child: Text(PlannerNotes.wallFor(concrete: plan.inputs.concreteWall)),
        ),
      ],
    );
  }
}
