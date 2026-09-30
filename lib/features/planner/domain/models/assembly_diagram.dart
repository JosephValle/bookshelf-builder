import 'package:bookshelf_builder/features/planner/domain/models/diagram_arrow.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_dimension.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_label.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_shape.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assembly_diagram.freezed.dart';

/// A picture that goes with an assembly step, drawn to scale.
///
/// One scale applies to the whole picture. Tags, screw symbols and arrows are
/// fixed size, and a caption says so when a view is cut off.
@freezed
abstract class AssemblyDiagram with _$AssemblyDiagram {
  const AssemblyDiagram._();

  /// Creates a diagram.
  const factory AssemblyDiagram({
    /// Says what the picture shows and what each piece letter is.
    required String caption,

    /// Width of the drawing area, in diagram units.
    required double width,

    /// Height of the drawing area, in diagram units.
    required double height,

    /// Shapes in painting order (later shapes are on top).
    required List<DiagramShape> shapes,

    /// Arrows drawn over the shapes.
    @Default([]) List<DiagramArrow> arrows,

    /// Screws and brads, drawn over the shapes.
    @Default([]) List<DiagramMark> marks,

    /// Measurement lines, for example the distance from an edge to a screw.
    @Default([]) List<DiagramDimension> dimensions,

    /// The pieces and hardware this step uses.
    @Default([]) List<DiagramPiece> pieces,

    /// Free floating text such as the ids of thin panels.
    @Default([]) List<DiagramLabel> labels,

    /// True for a picture drawn at full page size, such as the labelled
    /// elevation, instead of the small step size.
    @Default(false) bool large,
  }) = _AssemblyDiagram;

  /// Returns a copy with [pieces] in place of the current strip.
  AssemblyDiagram withPieces(List<DiagramPiece> pieces) =>
      copyWith(pieces: pieces);
}
