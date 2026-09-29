import 'package:bookshelf_builder/app/theme/radii.dart';
import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:flutter/material.dart';

/// A titled card that groups one part of the materials list.
///
/// The title is exposed to assistive technology as a heading.
class SectionCard extends StatelessWidget {
  /// Creates a card with a [title], an [icon] and its [child] content.
  const SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    super.key,
  });

  /// Heading text.
  final String title;

  /// Icon shown before the title.
  final IconData icon;

  /// Card content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: Space.md),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.md),
        side: BorderSide(color: scheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Space.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Row(
                children: [
                  Icon(icon, color: scheme.primary),
                  const SizedBox(width: Space.sm),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Space.md),
            child,
          ],
        ),
      ),
    );
  }
}
