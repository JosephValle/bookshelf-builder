import 'package:bookshelf_builder/features/planner/domain/models/layout_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cut_sheet.freezed.dart';

/// How one 4x8 sheet of plywood is cut up: which piece goes where.
///
/// Pieces sit in strips ripped along the length of the sheet. Each strip is
/// then crosscut into pieces, with one saw kerf between neighbours.
@freezed
abstract class CutSheet with _$CutSheet {
  const CutSheet._();

  /// Creates a sheet layout.
  const factory CutSheet({
    /// Whether this is a 3/4" or a 1/4" sheet.
    required PartMaterial material,

    /// Which sheet of its material this is, counting from 1.
    required int number,

    /// Every piece cut from the sheet.
    required List<LayoutPiece> pieces,
  }) = _CutSheet;

  /// The top edge of every strip, in order. A strip is every piece that shares
  /// a top edge.
  List<double> get stripTops =>
      ({for (final p in pieces) p.y}.toList()..sort());

  /// The pieces of the strip whose top edge is [top], left to right.
  List<LayoutPiece> strip(double top) =>
      pieces.where((p) => (p.y - top).abs() < 1e-9).toList()
        ..sort((a, b) => a.x.compareTo(b.x));

  /// Width of the strip whose top edge is [top].
  double stripWidth(double top) =>
      strip(top).fold<double>(0, (w, p) => p.width > w ? p.width : w);

  /// Distance from the top long edge to the finished lower edge of every
  /// strip: where to mark each rip cut. The saw cuts just past each mark, on
  /// the waste side.
  List<double> get ripMarks => [for (final t in stripTops) t + stripWidth(t)];
}
