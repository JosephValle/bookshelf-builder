import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:equatable/equatable.dart';

/// State of the planner screen: the current inputs, the plan computed from
/// them, and an optional one-shot message for the user.
class PlannerState extends Equatable {
  /// Creates a state.
  const PlannerState({
    required this.inputs,
    required this.plan,
    this.notice,
    this.noticeId = 0,
    this.savedPath,
  });

  /// Current inputs.
  final Inputs inputs;

  /// Plan computed from [inputs].
  final Plan plan;

  /// Message to show once (for example "Cut list copied"), or null.
  final String? notice;

  /// Increments with every notice so identical messages still notify.
  final int noticeId;

  /// Path of the PDF that was just saved, so the message can offer to show it
  /// in the file manager, or null.
  final String? savedPath;

  @override
  List<Object?> get props => [inputs, plan, notice, noticeId, savedPath];
}
