import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagram_piece.freezed.dart';

/// One entry of the "pieces you need" strip above a step's picture: a cut
/// piece (with a letter) or hardware such as screws (empty letter).
@freezed
abstract class DiagramPiece with _$DiagramPiece {
  /// Creates an entry.
  const factory DiagramPiece(
    /// Piece id, or empty for hardware such as screws and glue.
    String label,

    /// How many this step uses. Zero means an unspecified amount (glue).
    int qty,

    /// What the piece is, for example "top panel".
    String name,
  ) = _DiagramPiece;
}
