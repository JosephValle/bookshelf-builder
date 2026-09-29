import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/bar_planner.dart';
import 'package:bookshelf_builder/features/planner/domain/services/column_planner.dart';
import 'package:bookshelf_builder/features/planner/domain/services/geometry_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/issue_checker.dart';
import 'package:bookshelf_builder/features/planner/domain/services/parts_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/sheet_estimator.dart';

/// Turns [Inputs] into a complete [Plan]. Pure Dart and deterministic.
///
/// Each stage is a small injectable service so it can be tested on its own.
class PlanEngine {
  /// Creates an engine with the standard stages.
  const PlanEngine({
    this.columns = const ColumnPlanner(),
    this.bars = const BarPlanner(),
    this.partsBuilder = const PartsBuilder(),
    this.geometryBuilder = const GeometryBuilder(),
    this.sheetEstimator = const SheetEstimator(),
    this.issueChecker = const IssueChecker(),
  });

  /// Plans side columns.
  final ColumnPlanner columns;

  /// Plans the top and bottom bars.
  final BarPlanner bars;

  /// Builds the cut list.
  final PartsBuilder partsBuilder;

  /// Builds the drawing geometry.
  final GeometryBuilder geometryBuilder;

  /// Estimates sheets.
  final SheetEstimator sheetEstimator;

  /// Produces warnings and errors.
  final IssueChecker issueChecker;

  /// Computes the plan for [inputs].
  ///
  /// Column widths are resolved first (see [Inputs.resolved]) so a wall width
  /// grows the columns. Bar dividers are spaced at the preferred shelf width,
  /// capped by the structural limit: the box beam spacing for the top bar (and
  /// for the bottom bar off the floor), the shelf span limit for a bottom bar
  /// resting on the floor.
  Plan compute(Inputs raw) {
    final inputs = raw.resolved;
    final dims = Dimensions.from(inputs);
    final leftCol = columns.plan(inputs.left, inputs, dims);
    final rightCol = columns.plan(inputs.right, inputs, dims);
    const topLimit = Limits.boxBeamMaxWebSpacing;
    final bottomLimit = inputs.onFloor
        ? dims.spanLimit
        : Limits.boxBeamMaxWebSpacing;
    final topBar = bars.plan(
      windowW: inputs.openW,
      barH: inputs.top,
      kick: 0,
      span: math.min(dims.shelfWidth, topLimit),
    );
    final bottomBar = bars.plan(
      windowW: inputs.openW,
      barH: inputs.bottom,
      kick: dims.kick,
      span: math.min(dims.shelfWidth, bottomLimit),
    );
    final parts = partsBuilder.build(
      inputs: inputs,
      dims: dims,
      leftCol: leftCol,
      rightCol: rightCol,
      topBar: topBar,
      bottomBar: bottomBar,
    );
    final geometry = geometryBuilder.build(
      inputs: inputs,
      dims: dims,
      leftCol: leftCol,
      rightCol: rightCol,
      topBar: topBar,
      bottomBar: bottomBar,
      topBarSpanLimit: topLimit,
      bottomBarSpanLimit: bottomLimit,
    );
    return Plan(
      inputs: inputs,
      dimensions: dims,
      leftCol: leftCol,
      rightCol: rightCol,
      topBar: topBar,
      bottomBar: bottomBar,
      parts: parts,
      geometry: geometry,
      sheets: sheetEstimator.estimate(parts: parts, dims: dims, inputs: inputs),
      issues: issueChecker.check(
        inputs: inputs,
        dims: dims,
        parts: parts,
        bays: geometry.bays,
      ),
    );
  }
}
