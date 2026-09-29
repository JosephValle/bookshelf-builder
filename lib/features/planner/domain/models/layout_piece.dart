import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout_piece.freezed.dart';

/// One piece placed on a plywood sheet in a cutting layout.
///
/// The sheet is 96 in long (x) and 48 in wide (y). The origin is the top left
/// corner of the sheet as drawn, and the piece length runs along x.
@freezed
abstract class LayoutPiece with _$LayoutPiece {
  /// Creates a placed piece.
  const factory LayoutPiece({
    /// The piece id from the cut list, for example `D3`.
    required String id,

    /// The part name, for example `Left column shelf`.
    required String name,

    /// Distance from the left end of the sheet to the start of the piece.
    required double x,

    /// Distance from the top long edge of the sheet to the top of the piece.
    required double y,

    /// Length of the piece as cut, along the sheet.
    required double length,

    /// Width of the piece as cut, across the sheet.
    required double width,
  }) = _LayoutPiece;
}
