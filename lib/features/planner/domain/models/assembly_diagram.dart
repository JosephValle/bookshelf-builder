import 'package:bookshelf_builder/features/planner/domain/models/diagram_arrow.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_dimension.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_shape.dart';
import 'package:equatable/equatable.dart';

/// A rough, not to scale picture that goes with an assembly step.
class AssemblyDiagram extends Equatable {
  /// Creates a diagram.
  const AssemblyDiagram({
    required this.caption,
    required this.width,
    required this.height,
    required this.shapes,
    this.arrows = const [],
    this.marks = const [],
    this.dimensions = const [],
    this.pieces = const [],
  });

  /// Says what the picture shows and what each piece letter is.
  final String caption;

  /// Width of the drawing area, in diagram units.
  final double width;

  /// Height of the drawing area, in diagram units.
  final double height;

  /// Shapes in painting order (later shapes are on top).
  final List<DiagramShape> shapes;

  /// Arrows drawn over the shapes.
  final List<DiagramArrow> arrows;

  /// Screws and brads, drawn over the shapes.
  final List<DiagramMark> marks;

  /// Measurement lines, for example the distance from an edge to a screw.
  final List<DiagramDimension> dimensions;

  /// The pieces and hardware this step uses, shown as "2x A" style entries.
  final List<DiagramPiece> pieces;

  /// Returns a copy with [pieces] in place of the current strip.
  AssemblyDiagram withPieces(List<DiagramPiece> pieces) => AssemblyDiagram(
    caption: caption,
    width: width,
    height: height,
    shapes: shapes,
    arrows: arrows,
    marks: marks,
    dimensions: dimensions,
    pieces: pieces,
  );

  @override
  List<Object?> get props => [
    caption,
    width,
    height,
    shapes,
    arrows,
    marks,
    dimensions,
    pieces,
  ];
}
