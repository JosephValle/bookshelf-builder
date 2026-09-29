import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_heading.dart';
import 'package:flutter/material.dart';

/// Sheet counts, edge band length, store note and wall attachment note.
class MaterialsView extends StatelessWidget {
  /// Creates the view for [plan].
  const MaterialsView({required this.plan, super.key});

  /// Plan to summarize.
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    const f = InchesFormatter();
    final s = plan.sheets;
    return ListView(
      padding: const EdgeInsets.all(Space.md),
      children: [
        const SectionHeading('Plywood'),
        Text('3/4" plywood: ${s.sheets34} sheets'),
        Text(
          '${s.neededStrips} strips of ${f.format(plan.depthPanel)}, '
          '${s.stripsPerSheet} per 4x8 sheet',
        ),
        const SizedBox(height: Space.sm),
        Text('1/4" plywood: ${s.backSheets} sheets (approximate)'),
        if (plan.inputs.edgeStiffener) ...[
          const SizedBox(height: Space.sm),
          Text(
            'Front edge band: '
            '${(plan.edgeBandInches / 12).toStringAsFixed(1)} linear feet',
          ),
        ],
        const SectionHeading('Buying'),
        const Text(PlannerNotes.store),
        const SectionHeading('Wall attachment'),
        const Text(PlannerNotes.wall),
      ],
    );
  }
}
