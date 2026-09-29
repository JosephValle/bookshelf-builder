import 'package:equatable/equatable.dart';

/// Four lengths, one for each side of a rectangle, in inches.
class Sides extends Equatable {
  /// Creates sides.
  const Sides({this.top = 0, this.bottom = 0, this.left = 0, this.right = 0});

  /// Top side.
  final double top;

  /// Bottom side.
  final double bottom;

  /// Left side.
  final double left;

  /// Right side.
  final double right;

  /// True when the top equals the bottom and the left equals the right, so
  /// the sides can be edited as a vertical and a horizontal value.
  bool get isPaired => top == bottom && left == right;

  /// Returns a copy with the given sides replaced.
  Sides copyWith({double? top, double? bottom, double? left, double? right}) =>
      Sides(
        top: top ?? this.top,
        bottom: bottom ?? this.bottom,
        left: left ?? this.left,
        right: right ?? this.right,
      );

  @override
  List<Object?> get props => [top, bottom, left, right];
}
