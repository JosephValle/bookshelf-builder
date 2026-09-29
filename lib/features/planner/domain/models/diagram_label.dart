import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagram_label.freezed.dart';

/// A small piece of text on an assembly diagram that is not inside a shape,
/// used to name panels that are too thin to hold their own label.
@freezed
abstract class DiagramLabel with _$DiagramLabel {
  /// Creates a label centered on a point.
  const factory DiagramLabel(
    /// Center of the text.
    DiagramPoint at,

    /// The text, usually a piece id such as `D3`.
    String text,
  ) = _DiagramLabel;
}
