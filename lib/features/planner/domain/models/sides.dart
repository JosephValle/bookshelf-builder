import 'package:freezed_annotation/freezed_annotation.dart';

part 'sides.freezed.dart';

/// Four lengths, one for each side of a rectangle, in inches.
@freezed
abstract class Sides with _$Sides {
  const Sides._();

  /// Creates sides.
  const factory Sides({
    /// Top side.
    @Default(0) double top,

    /// Bottom side.
    @Default(0) double bottom,

    /// Left side.
    @Default(0) double left,

    /// Right side.
    @Default(0) double right,
  }) = _Sides;

  /// True when the top equals the bottom and the left equals the right, so
  /// the sides can be edited as a vertical and a horizontal value.
  bool get isPaired => top == bottom && left == right;
}
