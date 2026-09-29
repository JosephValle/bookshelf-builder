import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagram_arrow.freezed.dart';

/// An arrow on an assembly diagram showing which way a part moves.
@freezed
abstract class DiagramArrow with _$DiagramArrow {
  /// Creates an arrow from the first point to the second.
  const factory DiagramArrow(
    /// Tail of the arrow.
    DiagramPoint from,

    /// Head of the arrow.
    DiagramPoint to,
  ) = _DiagramArrow;
}
