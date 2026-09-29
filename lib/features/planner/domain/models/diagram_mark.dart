import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark_kind.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:equatable/equatable.dart';

/// A fastener drawn on an assembly diagram.
class DiagramMark extends Equatable {
  /// Creates a mark at [at].
  const DiagramMark(this.at, {this.kind = DiagramMarkKind.screw});

  /// Where the fastener goes.
  final DiagramPoint at;

  /// Screw or nail.
  final DiagramMarkKind kind;

  @override
  List<Object?> get props => [at, kind];
}
