import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:equatable/equatable.dart';

/// A measurement line on an assembly diagram, such as the 1" from the edge to
/// a screw.
class DiagramDimension extends Equatable {
  /// Creates a dimension line from [from] to [to] labelled [text].
  const DiagramDimension(this.from, this.to, this.text);

  /// One end of the measured distance.
  final DiagramPoint from;

  /// The other end of the measured distance.
  final DiagramPoint to;

  /// The measurement, for example `1"`.
  final String text;

  @override
  List<Object?> get props => [from, to, text];
}
