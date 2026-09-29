import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:equatable/equatable.dart';

/// An arrow on an assembly diagram showing which way a part moves.
class DiagramArrow extends Equatable {
  /// Creates an arrow from [from] to [to].
  const DiagramArrow(this.from, this.to);

  /// Tail of the arrow.
  final DiagramPoint from;

  /// Head of the arrow.
  final DiagramPoint to;

  @override
  List<Object?> get props => [from, to];
}
