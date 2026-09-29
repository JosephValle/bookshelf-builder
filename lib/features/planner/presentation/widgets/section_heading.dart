import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:flutter/material.dart';

/// A section title exposed to assistive technology as a heading.
class SectionHeading extends StatelessWidget {
  /// Creates a heading with [text].
  const SectionHeading(this.text, {super.key});

  /// Heading text.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.only(top: Space.md, bottom: Space.xs),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
