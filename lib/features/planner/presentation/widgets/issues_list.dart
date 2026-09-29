import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/issue.dart';
import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:flutter/material.dart';

/// Lists warnings, errors and notes with an icon and a text severity label.
class IssuesList extends StatelessWidget {
  /// Creates the list.
  const IssuesList({required this.issues, super.key});

  /// Issues to show.
  final List<Issue> issues;

  @override
  Widget build(BuildContext context) {
    if (issues.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(Space.md),
        child: Text('No warnings or errors.'),
      );
    }
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(Space.md),
      children: [
        for (final i in issues)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              switch (i.severity) {
                Severity.error => Icons.error,
                Severity.warning => Icons.warning_amber,
                Severity.note => Icons.info_outline,
              },
              color: i.severity == Severity.error
                  ? scheme.error
                  : scheme.onSurface,
            ),
            title: Text(i.message),
            subtitle: Text(switch (i.severity) {
              Severity.error => 'Error',
              Severity.warning => 'Warning',
              Severity.note => 'Note',
            }),
          ),
      ],
    );
  }
}
