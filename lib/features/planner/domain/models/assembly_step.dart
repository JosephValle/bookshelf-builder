import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assembly_step.freezed.dart';

/// One numbered step of the assembly guide.
@freezed
abstract class AssemblyStep with _$AssemblyStep {
  /// Creates a step.
  const factory AssemblyStep(
    /// Short heading, for example "Build the columns".
    String title,

    /// Instructions and measurements, one line each.
    List<String> details, {

    /// Rough pictures for the step, in the order they are shown. Empty for a
    /// step that needs none.
    @Default([]) List<AssemblyDiagram> diagrams,

    /// The tools this step uses, each with what it is used for, for example
    /// "Drill with a 1/8 inch bit: pilot holes".
    @Default([]) List<String> tools,

    /// The screws, nails, glue and other hardware this step uses, with
    /// counts.
    @Default([]) List<String> hardware,

    /// True for a "your build should look like this now" step: the details
    /// are things to check and the picture shows the finished state so far.
    @Default(false) bool checkpoint,
  }) = _AssemblyStep;
}
