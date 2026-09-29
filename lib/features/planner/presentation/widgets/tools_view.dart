import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/tool_recommendation.dart';
import 'package:bookshelf_builder/features/planner/domain/services/tool_recommender.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';

/// Recommended tools and supplies as a checklist: bold names, muted reasons,
/// and an "Optional" badge on the nice-to-have items.
class ToolsView extends StatelessWidget {
  /// Creates the view for [plan].
  const ToolsView({required this.plan, super.key});

  /// Plan to recommend tools for.
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    final tools = const ToolRecommender().recommend(plan);
    return SectionCard(
      title: 'Recommended tools',
      icon: Icons.handyman_outlined,
      child: Column(children: [for (final t in tools) _ToolTile(tool: t)]),
    );
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({required this.tool});

  final ToolRecommendation tool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            tool.essential
                ? Icons.check_circle_outline
                : Icons.add_circle_outline,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: Space.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      tool.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (!tool.essential)
                      Chip(
                        visualDensity: VisualDensity.compact,
                        label: const Text('Optional'),
                        padding: EdgeInsets.zero,
                        labelStyle: theme.textTheme.labelSmall,
                      ),
                  ],
                ),
                Text(
                  tool.reason,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
