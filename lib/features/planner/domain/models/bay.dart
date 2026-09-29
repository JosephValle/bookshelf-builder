import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:equatable/equatable.dart';

/// A clear opening between panels where books sit.
class Bay extends Equatable {
  /// Creates a bay.
  const Bay(this.box, this.bad);

  /// Clear opening rectangle.
  final Box box;

  /// True when the bay violates a size or span limit.
  final bool bad;

  @override
  List<Object?> get props => [box, bad];
}
