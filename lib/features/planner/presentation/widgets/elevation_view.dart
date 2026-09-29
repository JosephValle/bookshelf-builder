import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_painter.dart';
import 'package:flutter/material.dart';

/// The elevation drawing sized to its parent, with a text description for
/// assistive technology.
class ElevationView extends StatelessWidget {
  /// Creates the view for [plan].
  const ElevationView({required this.plan, super.key});

  /// Plan to draw.
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    const f = InchesFormatter();
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label:
          'Front elevation, ${f.format(plan.ringW)} wide by '
          '${f.format(plan.ringH)} tall',
      image: true,
      child: RepaintBoundary(
        child: CustomPaint(
          painter: ElevationPainter(
            plan,
            ink: scheme.onSurface,
            paper: scheme.surface,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
