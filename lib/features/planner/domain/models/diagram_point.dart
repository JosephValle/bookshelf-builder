import 'package:equatable/equatable.dart';

/// A point on an assembly diagram. The diagrams are schematic, so the unit is
/// abstract (not inches) and y grows downward.
class DiagramPoint extends Equatable {
  /// Creates a point.
  const DiagramPoint(this.x, this.y);

  /// Horizontal position.
  final double x;

  /// Vertical position, growing downward.
  final double y;

  @override
  List<Object?> get props => [x, y];
}
