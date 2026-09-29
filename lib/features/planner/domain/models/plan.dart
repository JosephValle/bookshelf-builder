import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/geometry.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/issue.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sheet_plan.dart';
import 'package:equatable/equatable.dart';

/// The complete result of planning one set of [Inputs].
class Plan extends Equatable {
  /// Creates a plan.
  const Plan({
    required this.inputs,
    required this.dimensions,
    required this.leftCol,
    required this.rightCol,
    required this.topBar,
    required this.bottomBar,
    required this.parts,
    required this.geometry,
    required this.sheets,
    required this.issues,
  });

  /// The inputs this plan was computed from.
  final Inputs inputs;

  /// Derived overall dimensions.
  final Dimensions dimensions;

  /// Left column layout.
  final ColumnPlan leftCol;

  /// Right column layout.
  final ColumnPlan rightCol;

  /// Top bar layout.
  final BarPlan topBar;

  /// Bottom bar layout.
  final BarPlan bottomBar;

  /// The cut list.
  final List<Part> parts;

  /// Drawable layout.
  final Geometry geometry;

  /// Plywood sheet estimate.
  final SheetPlan sheets;

  /// Warnings, errors and notes.
  final List<Issue> issues;

  /// Overall ring width.
  double get ringW => dimensions.ringW;

  /// Overall ring height.
  double get ringH => dimensions.ringH;

  /// Depth of every 3/4" panel.
  double get depthPanel => dimensions.depthPanel;

  /// Toe kick height (zero when not on the floor).
  double get kick => dimensions.kick;

  /// Length of the vertical column panels.
  double get sideH => dimensions.sideH;

  /// Active maximum clear shelf span.
  double get spanLimit => dimensions.spanLimit;

  /// Widest shelf bay the planner allows.
  double get shelfWidth => dimensions.shelfWidth;

  /// Horizontal position of the ring on the wall (see
  /// [Inputs.effectiveRingOffset]).
  double? get ringOffsetOnWall => inputs.effectiveRingOffset;

  /// Issues with [Severity.error].
  List<Issue> get errors =>
      issues.where((i) => i.severity == Severity.error).toList();

  /// Issues with [Severity.warning].
  List<Issue> get warnings =>
      issues.where((i) => i.severity == Severity.warning).toList();

  /// Total front edge band length in inches (zero when disabled).
  double get edgeBandInches => parts
      .where((p) => p.material == PartMaterial.edgeBand)
      .fold(0.0, (sum, p) => sum + p.length);

  @override
  List<Object?> get props => [
    inputs,
    dimensions,
    leftCol,
    rightCol,
    topBar,
    bottomBar,
    parts,
    geometry,
    sheets,
    issues,
  ];
}
