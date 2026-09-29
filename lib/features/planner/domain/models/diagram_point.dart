import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagram_point.freezed.dart';

/// A point on an assembly diagram. The diagrams are schematic, so the unit is
/// abstract (not inches) and y grows downward.
@freezed
abstract class DiagramPoint with _$DiagramPoint {
  /// Creates a point.
  const factory DiagramPoint(
    /// Horizontal position.
    double x,

    /// Vertical position, growing downward.
    double y,
  ) = _DiagramPoint;
}
