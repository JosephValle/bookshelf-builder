import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'part.freezed.dart';

/// One line of the cut list.
@freezed
abstract class Part with _$Part {
  const Part._();

  /// Creates a cut list line.
  const factory Part(
    /// Part name.
    String name,

    /// Number of identical pieces.
    int qty,

    /// Length in inches. For an edge band this is the total run.
    double length,

    /// Width in inches. Zero for an edge band.
    double width,

    /// Material the part is cut from.
    PartMaterial material, {

    /// Length of the whole part before it was split to fit a sheet, or zero
    /// when the part was not spliced. [length] is then the length of each
    /// piece and [qty] counts the pieces.
    @Default(0) double splicedFrom,

    /// Piece letter shared by every part with the same material and size, for
    /// example `A`. Empty until the cut list has been labelled.
    @Default('') String label,

    /// Number of the first piece on this line. Pieces are numbered per letter
    /// across the whole cut list, so a line of two pieces that starts at 3
    /// holds pieces `A3` and `A4`.
    @Default(1) int firstNumber,
  }) = _Part;

  /// Returns a copy of this part with the piece letter [label] and its first
  /// piece number [firstNumber].
  Part withLabel(String label, {int firstNumber = 1}) =>
      copyWith(label: label, firstNumber: firstNumber);

  /// True when this line is one part cut in several pieces and joined.
  bool get isSpliced => splicedFrom > 0;

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
}
