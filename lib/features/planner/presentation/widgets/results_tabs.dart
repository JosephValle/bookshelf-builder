import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/cut_list_table.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/issues_list.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/materials_view.dart';
import 'package:flutter/material.dart';

/// Tabs for the cut list, materials and warnings.
class ResultsTabs extends StatelessWidget {
  /// Creates the tabs for [plan].
  const ResultsTabs({required this.plan, super.key});

  /// Plan to show.
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              const Tab(text: 'Cut list'),
              const Tab(text: 'Materials'),
              Tab(text: 'Warnings (${plan.issues.length})'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                CutListTable(plan: plan),
                MaterialsView(plan: plan),
                IssuesList(issues: plan.issues),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
