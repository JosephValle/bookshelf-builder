import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:equatable/equatable.dart';

/// A single warning, error or note produced while planning.
class Issue extends Equatable {
  /// Creates an issue.
  const Issue(this.severity, this.message);

  /// How serious the issue is.
  final Severity severity;

  /// Human readable description.
  final String message;

  @override
  List<Object?> get props => [severity, message];
}
