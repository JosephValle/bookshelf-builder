import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bay.freezed.dart';

/// A clear opening between panels where books sit.
@freezed
abstract class Bay with _$Bay {
  /// Creates a bay.
  const factory Bay(
    /// Clear opening rectangle.
    Box box,

    /// True when the bay violates a size or span limit.
    bool bad,
  ) = _Bay;
}
