import 'package:bookshelf_builder/app/theme/app_type.dart';
import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:flutter/material.dart';

/// Footer stating that the limits are rules of thumb.
class DisclaimerFooter extends StatelessWidget {
  /// Creates the footer.
  const DisclaimerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Space.md),
      child: Text(
        PlannerNotes.disclaimer,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(fontSize: AppType.footer),
      ),
    );
  }
}
