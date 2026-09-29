import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_tone.dart';
import 'package:equatable/equatable.dart';

/// One filled polygon on an assembly diagram, with an optional piece letter.
class DiagramShape extends Equatable {
  /// Creates a shape from its corner [points].
  const DiagramShape(
    this.points, {
    this.label = '',
    this.tone = DiagramTone.panel,
  });

  /// Creates a rectangle.
  factory DiagramShape.rect(
    double x,
    double y,
    double w,
    double h, {
    String label = '',
    DiagramTone tone = DiagramTone.panel,
  }) => DiagramShape(
    [
      DiagramPoint(x, y),
      DiagramPoint(x + w, y),
      DiagramPoint(x + w, y + h),
      DiagramPoint(x, y + h),
    ],
    label: label,
    tone: tone,
  );

  /// Corners in drawing order.
  final List<DiagramPoint> points;

  /// Piece letter written on the shape, or empty for none.
  final String label;

  /// What the shape represents.
  final DiagramTone tone;

  /// Average of the corners, where the label is written.
  DiagramPoint get center {
    var x = 0.0;
    var y = 0.0;
    for (final p in points) {
      x += p.x;
      y += p.y;
    }
    return DiagramPoint(x / points.length, y / points.length);
  }

  @override
  List<Object?> get props => [points, label, tone];
}
