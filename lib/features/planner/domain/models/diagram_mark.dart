import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark_kind.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagram_mark.freezed.dart';

/// A fastener drawn on an assembly diagram.
@freezed
abstract class DiagramMark with _$DiagramMark {
  /// Creates a mark at a point.
  const factory DiagramMark(
    /// Where the fastener goes.
    DiagramPoint at, {

    /// Screw or nail.
    @Default(DiagramMarkKind.screw) DiagramMarkKind kind,
  }) = _DiagramMark;
}
