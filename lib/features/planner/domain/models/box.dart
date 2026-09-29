import 'package:equatable/equatable.dart';

/// An axis aligned rectangle in inches.
///
/// The origin is the top left corner of the ring and y grows downward, so a
/// box maps directly onto the elevation drawing.
class Box extends Equatable {
  /// Creates a box.
  const Box(this.x, this.y, this.w, this.h);

  /// Left edge.
  final double x;

  /// Top edge.
  final double y;

  /// Width.
  final double w;

  /// Height.
  final double h;

  @override
  List<Object?> get props => [x, y, w, h];
}
