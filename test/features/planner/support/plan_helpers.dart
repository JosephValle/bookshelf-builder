import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/plan_engine.dart';

/// Computes a plan for [inputs] (defaults when omitted).
Plan planFor([Inputs inputs = const Inputs()]) =>
    const PlanEngine().compute(inputs);
