import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:equatable/equatable.dart';

/// One numbered step of the assembly guide.
class AssemblyStep extends Equatable {
  /// Creates a step.
  const AssemblyStep(this.title, this.details, {this.diagrams = const []});

  /// Short heading, for example "Build the columns".
  final String title;

  /// Instructions and measurements, one line each.
  final List<String> details;

  /// Rough pictures for the step, in the order they are shown. Empty for a
  /// step that needs none.
  final List<AssemblyDiagram> diagrams;

  @override
  List<Object?> get props => [title, details, diagrams];
}
