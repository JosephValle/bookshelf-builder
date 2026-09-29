import 'package:freezed_annotation/freezed_annotation.dart';

part 'box.freezed.dart';

/// An axis aligned rectangle in inches.
///
/// The origin is the top left corner of the ring and y grows downward, so a
/// box maps directly onto the elevation drawing.
@freezed
abstract class Box with _$Box {
  /// Creates a box.
  const factory Box(
    /// Left edge.
    double x,

    /// Top edge.
    double y,

    /// Width.
    double w,

    /// Height.
    double h,
  ) = _Box;
}
