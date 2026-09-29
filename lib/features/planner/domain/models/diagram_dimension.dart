import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagram_dimension.freezed.dart';

/// A measurement line on an assembly diagram, such as the 1" from the edge to
/// a screw.
@freezed
abstract class DiagramDimension with _$DiagramDimension {
  /// Creates a dimension line from one point to another, labelled with the
  /// measurement.
  const factory DiagramDimension(
    /// One end of the measured distance.
    DiagramPoint from,

    /// The other end of the measured distance.
    DiagramPoint to,

    /// The measurement, for example `1"`.
    String text, {

    /// True to draw the line and text in white, for a measurement written
    /// on a dark shape.
    @Default(false) bool light,
  }) = _DiagramDimension;
}
