import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue.freezed.dart';

/// A single warning, error or note produced while planning.
@freezed
abstract class Issue with _$Issue {
  /// Creates an issue.
  const factory Issue(
    /// How serious the issue is.
    Severity severity,

    /// Human readable description.
    String message,
  ) = _Issue;
}
