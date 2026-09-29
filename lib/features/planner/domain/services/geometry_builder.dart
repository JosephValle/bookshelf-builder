import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/bay.dart';
import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/geometry.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';

/// Lays out every panel and bay in inches for the elevation drawing.
///
/// The origin is the top left of the ring and y grows downward.
class GeometryBuilder {
  /// Creates a builder.
  const GeometryBuilder();

  /// Builds the drawable [Geometry].
  ///
  /// [barSpanLimit] maps the bottom bar's span limit, which depends on
  /// whether the ring rests on the floor.
  Geometry build({
    required Inputs inputs,
    required Dimensions dims,
    required ColumnPlan leftCol,
    required ColumnPlan rightCol,
    required BarPlan topBar,
    required BarPlan bottomBar,
    required double bottomBarSpanLimit,
    required double topBarSpanLimit,
  }) {
    const t = Limits.t;
    final panels = <Box>[];
    final bays = <Bay>[];
    final bottomY = dims.ringH - dims.kick;

    panels
      ..add(Box(0, 0, dims.ringW, t))
      ..add(Box(0, bottomY - t, dims.ringW, t))
      ..add(Box(inputs.left, inputs.top - t, inputs.openW, t))
      ..add(Box(inputs.left, inputs.top + inputs.openH, inputs.openW, t))
      ..add(Box(0, t, t, dims.sideH))
      ..add(Box(inputs.left - t, t, t, dims.sideH))
      ..add(Box(inputs.left + inputs.openW, t, t, dims.sideH))
      ..add(Box(dims.ringW - t, t, t, dims.sideH));

    void column(ColumnPlan c, double x0) {
      for (var r = 0; r <= c.shelves; r++) {
        final y = t + r * (c.clearH + t);
        if (r > 0) panels.add(Box(x0, y - t, c.clearW, t));
        for (var k = 0; k <= c.dividers; k++) {
          final x = x0 + k * (c.bayW + t);
          if (k > 0) panels.add(Box(x - t, y, t, c.clearH));
          final bad = c.bayW < Limits.minClearW || c.clearH < Limits.minClearH;
          bays.add(Bay(Box(x, y, c.bayW, c.clearH), bad));
        }
      }
    }

    column(leftCol, t);
    column(rightCol, inputs.left + inputs.openW + t);

    void bar(BarPlan b, double y0, double spanLimit) {
      final tierH = b.tiers == 2 ? (b.clearH - t) / 2 : b.clearH;
      for (var k = 0; k <= b.dividers; k++) {
        final x = inputs.left + k * (b.bayW + t);
        if (k > 0) panels.add(Box(x - t, y0, t, b.clearH));
        for (var r = 0; r < b.tiers; r++) {
          final y = y0 + r * (tierH + t);
          if (r > 0) panels.add(Box(x, y - t, b.bayW, t));
          final bad =
              b.bayW < Limits.minClearW ||
              tierH < Limits.minClearH ||
              b.bayW > spanLimit + 1e-9;
          bays.add(Bay(Box(x, y, b.bayW, tierH), bad));
        }
      }
    }

    bar(topBar, t, topBarSpanLimit);
    bar(bottomBar, inputs.top + inputs.openH + t, bottomBarSpanLimit);

    return Geometry(
      panels: panels,
      toeKickBox: inputs.onFloor
          ? Box(0, dims.ringH - dims.kick, dims.ringW, dims.kick)
          : null,
      bays: bays,
      windowBox: Box(
        inputs.left + inputs.gapLeft,
        inputs.top + inputs.gapTop,
        inputs.windowW,
        inputs.windowH,
      ),
      openingBox: Box(inputs.left, inputs.top, inputs.openW, inputs.openH),
    );
  }
}
