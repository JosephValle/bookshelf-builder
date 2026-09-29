import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_tone.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagram_shape.freezed.dart';

/// One filled polygon on an assembly diagram, with an optional piece letter.
@freezed
abstract class DiagramShape with _$DiagramShape {
  const DiagramShape._();

  /// Creates a shape from its corner points.
  const factory DiagramShape(
    /// Corners in drawing order.
    List<DiagramPoint> points, {

    /// Piece letter written on the shape, or empty for none.
    @Default('') String label,

    /// What the shape represents.
    @Default(DiagramTone.panel) DiagramTone tone,
  }) = _DiagramShape;

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
}
