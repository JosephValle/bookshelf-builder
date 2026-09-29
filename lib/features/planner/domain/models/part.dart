import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:equatable/equatable.dart';

/// One line of the cut list.
class Part extends Equatable {
  /// Creates a cut list line.
  const Part(
    this.name,
    this.qty,
    this.length,
    this.width,
    this.material, {
    this.splicedFrom = 0,
    this.label = '',
    this.firstNumber = 1,
  });

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

  /// Length of the whole part before it was split to fit a sheet, or zero when
  /// the part was not spliced. [length] is then the length of each piece and
  /// [qty] counts the pieces.
  final double splicedFrom;

  /// Piece letter shared by every part with the same material and size, for
  /// example `A`. Empty until the cut list has been labelled.
  final String label;

  /// Number of the first piece on this line. Pieces are numbered per letter
  /// across the whole cut list, so a line of two pieces that starts at 3 holds
  /// pieces `A3` and `A4`.
  final int firstNumber;

  /// Returns a copy of this part with the piece letter [label] and its first
  /// piece number [firstNumber].
  Part withLabel(String label, {int firstNumber = 1}) => Part(
    name,
    qty,
    length,
    width,
    material,
    splicedFrom: splicedFrom,
    label: label,
    firstNumber: firstNumber,
  );

  /// The id of every piece on this line, for example `[A1, A2]`. Empty until
  /// the cut list has been labelled.
  List<String> get ids => label.isEmpty
      ? const []
      : [for (var k = 0; k < qty; k++) '$label${firstNumber + k}'];

  /// The ids as text: `A1` for one piece, `A1-A4` for several.
  String get idRange {
    final all = ids;
    if (all.isEmpty) return '';
    return all.length == 1 ? all.first : '${all.first}-${all.last}';
  }

  /// True when this line is one part cut in several pieces and joined.
  bool get isSpliced => splicedFrom > 0;

  @override
  List<Object?> get props => [
    name,
    qty,
    length,
    width,
    material,
    splicedFrom,
    label,
    firstNumber,
  ];
}
