import 'package:equatable/equatable.dart';

/// One entry of the "pieces you need" strip above a step's picture: a cut
/// piece (with a letter) or hardware such as screws (empty letter).
class DiagramPiece extends Equatable {
  /// Creates an entry.
  const DiagramPiece(this.label, this.qty, this.name);

  /// Piece letter, or empty for hardware such as screws and glue.
  final String label;

  /// How many this step uses. Zero means an unspecified amount (glue).
  final int qty;

  /// What the piece is, for example "top panel".
  final String name;

  @override
  List<Object?> get props => [label, qty, name];
}
