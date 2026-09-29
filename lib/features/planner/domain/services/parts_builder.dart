import 'dart:math' as math;

import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';

/// Builds the cut list from the column and bar plans.
class PartsBuilder {
  /// Creates a builder.
  const PartsBuilder();

  /// Name of the toe kick part (it is ripped from a different width).
  static const String toeKickName = 'Toe kick';

  /// Name of the solid anchor cleat inside the top bar.
  static const String topCleatName = 'Top bar anchor cleat';

  /// Name of the solid anchor cleat inside the bottom bar (off the floor only).
  static const String bottomCleatName = 'Bottom bar anchor cleat';

  /// True for parts ripped to a narrow width instead of the panel depth.
  static bool isNarrowStrip(String name) =>
      name == toeKickName || name == topCleatName || name == bottomCleatName;

  /// Builds every part, including the optional toe kick and edge band.
  List<Part> build({
    required Inputs inputs,
    required Dimensions dims,
    required ColumnPlan leftCol,
    required ColumnPlan rightCol,
    required BarPlan topBar,
    required BarPlan bottomBar,
  }) {
    final parts = <Part>[];
    final dp = dims.depthPanel;
    void add(
      String name,
      int qty,
      double length,
      double width,
      PartMaterial material,
    ) {
      if (qty > 0) parts.add(Part(name, qty, length, width, material));
    }

    const p34 = PartMaterial.ply34;
    add('Top panel', 1, dims.ringW, dp, p34);
    add('Bottom panel', 1, dims.ringW, dp, p34);
    add('Outer column panel', 2, dims.sideH, dp, p34);
    add('Inner column panel', 2, dims.sideH, dp, p34);
    add('Head panel', 1, inputs.windowW, dp, p34);
    add('Sill panel', 1, inputs.windowW, dp, p34);
    add('Left column shelf', leftCol.shelves, leftCol.clearW, dp, p34);
    add('Right column shelf', rightCol.shelves, rightCol.clearW, dp, p34);
    add('Top bar divider', topBar.dividers, topBar.dividerLength, dp, p34);
    add(
      'Bottom bar divider',
      bottomBar.dividers,
      bottomBar.dividerLength,
      dp,
      p34,
    );
    if (topBar.tiers == 2) {
      add('Top bar shelf', topBar.dividers + 1, topBar.bayW, dp, p34);
    }
    if (bottomBar.tiers == 2) {
      add('Bottom bar shelf', bottomBar.dividers + 1, bottomBar.bayW, dp, p34);
    }
    add(
      'Left column divider',
      leftCol.dividers * (leftCol.shelves + 1),
      leftCol.clearH,
      dp,
      p34,
    );
    add(
      'Right column divider',
      rightCol.dividers * (rightCol.shelves + 1),
      rightCol.clearH,
      dp,
      p34,
    );
    if (inputs.onFloor) {
      add(toeKickName, 1, dims.ringW, inputs.toeKick, p34);
    }
    final cleatW = math.min(Limits.anchorCleatW, topBar.clearH);
    add(topCleatName, 1, inputs.windowW, cleatW, p34);
    if (!inputs.onFloor) {
      add(
        bottomCleatName,
        1,
        inputs.windowW,
        math.min(Limits.anchorCleatW, bottomBar.clearH),
        p34,
      );
    }
    const p14 = PartMaterial.ply14;
    add('Back panel, left column', 1, dims.ringH, inputs.left, p14);
    add('Back panel, right column', 1, dims.ringH, inputs.right, p14);
    add('Back panel, top bar', 1, inputs.windowW, inputs.top, p14);
    add('Back panel, bottom bar', 1, inputs.windowW, inputs.bottom, p14);

    if (inputs.edgeStiffener) {
      var edge = dims.ringW * 2 + inputs.windowW * 2;
      edge +=
          leftCol.clearW * leftCol.shelves + rightCol.clearW * rightCol.shelves;
      if (topBar.tiers == 2) edge += topBar.bayW * (topBar.dividers + 1);
      if (bottomBar.tiers == 2) {
        edge += bottomBar.bayW * (bottomBar.dividers + 1);
      }
      parts.add(
        Part('Front edge band (total)', 1, edge, 0, PartMaterial.edgeBand),
      );
    }
    return parts;
  }
}
