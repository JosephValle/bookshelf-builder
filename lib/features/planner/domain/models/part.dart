import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:equatable/equatable.dart';

/// One line of the cut list.
class Part extends Equatable {
  /// Creates a cut list line.
  const Part(this.name, this.qty, this.length, this.width, this.material);

  /// Part name.
  final String name;

  /// Number of identical pieces.
  final int qty;

  /// Length in inches. For an edge band this is the total run.
  final double length;

  /// Width in inches. Zero for an edge band.
  final double width;

  /// Material the part is cut from.
  final PartMaterial material;

  @override
  List<Object?> get props => [name, qty, length, width, material];
}
