import 'package:equatable/equatable.dart';

/// One numbered step of the assembly guide.
class AssemblyStep extends Equatable {
  /// Creates a step.
  const AssemblyStep(this.title, this.details);

  /// Short heading, for example "Build the columns".
  final String title;

  /// Instructions and measurements, one line each.
  final List<String> details;

  @override
  List<Object?> get props => [title, details];
}
