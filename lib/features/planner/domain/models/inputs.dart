import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sides.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inputs.freezed.dart';
part 'inputs.g.dart';

/// Every value the user can change. Immutable; use [copyWith] to derive edits.
///
/// All lengths are in inches. The defaults describe a 48" square window with
/// 14" columns and bars on a 3.5" toe kick.
@freezed
abstract class Inputs with _$Inputs {
  const Inputs._();

  /// The layout the app starts with: a 51 3/4" by 38" window, 57" from the
  /// left of a 140" by 96" wall and 42" off the floor, with 4" kept clear at
  /// the ceiling for a leaning book ladder and studs 18" apart.
  static const home = Inputs(
    windowW: 51.75,
    windowH: 38,
    wallW: 140,
    wallH: 96,
    wallMarginTop: 4,
    windowFromWallLeft: 57,
    windowFromFloor: 42,
    studSpacing: 18,
  );

  /// Creates inputs, defaulting to the standard starting layout.
  const factory Inputs({
    /// Window width (the glass or frame you are building around).
    @Default(48) double windowW,

    /// Window height.
    @Default(48) double windowH,

    /// Trim (casing) on the window's top side. Trim is the boards around the
    /// window itself; gaps are extra clearance beyond the trim.
    @Default(0) double trimTop,

    /// Trim on the window's bottom side.
    @Default(0) double trimBottom,

    /// Trim on the window's left side.
    @Default(0) double trimLeft,

    /// Trim on the window's right side.
    @Default(0) double trimRight,

    /// Clearance left between the trim (or the window) and the shelves above.
    @Default(0) double gapTop,

    /// Clearance between the trim (or the window) and the shelves below.
    @Default(0) double gapBottom,

    /// Clearance between the trim (or the window) and the left column.
    @Default(0) double gapLeft,

    /// Clearance between the trim (or the window) and the right column.
    @Default(0) double gapRight,

    /// Left column outer width.
    @Default(14) double left,

    /// Right column outer width.
    @Default(14) double right,

    /// Top bar height from ring top to window top.
    @Default(14) double top,

    /// Bottom bar height from window bottom to ring bottom, including the kick.
    @Default(14) double bottom,

    /// Total depth including the back panel.
    @Default(11.25) double depth,

    /// Whether the ring sits on a toe kick on the floor.
    @Default(true) bool onFloor,

    /// Toe kick height, used only when [onFloor] is true.
    @Default(3.5) double toeKick,

    /// Desired shelf opening height in the columns.
    @Default(11) double targetClearH,

    /// Whether a solid front edge band is added to horizontal panels.
    @Default(false) bool edgeStiffener,

    /// Preferred maximum clear shelf width. Dividers are added whenever a bay
    /// would be wider, and it is capped by the structural span limits.
    @Default(24) double maxShelfWidth,

    /// Whether the columns grow to fill the whole wall width when a wall width
    /// is set. When false the ring keeps its column widths and sits on the wall.
    @Default(true) bool fillWall,

    /// Whether the wall is concrete or masonry instead of studs and drywall.
    /// It changes how the wall half of the cleat is fastened and which tools
    /// and fasteners the guide calls for.
    @Default(false) bool concreteWall,

    /// Distance between the wall studs, center to center. Used to count the
    /// screws for the wall half of the cleat. Ignored for a concrete wall.
    @Default(Limits.studSpacing) double studSpacing,

    /// Optional wall width.
    double? wallW,

    /// Optional wall height (floor to ceiling) for fit checks.
    double? wallH,

    /// Distance from the ceiling that the shelves must stay clear of (crown
    /// molding, a soffit). Used with [wallH].
    @Default(0) double wallMarginTop,

    /// Distance from the wall's left edge that the shelves must stay clear of
    /// (a door, trim, an adjacent cabinet). Used with [wallW].
    @Default(0) double wallMarginLeft,

    /// Distance from the wall's right edge that the shelves must stay clear of.
    /// Used with [wallW]. The bottom of the wall is the floor, so it has no
    /// margin.
    @Default(0) double wallMarginRight,

    /// Optional distance from the wall's left edge to the window's left edge.
    /// Centered on the wall when unset.
    double? windowFromWallLeft,

    /// Optional distance from the floor to the window's bottom edge. Centered
    /// between the floor and the top margin when unset.
    double? windowFromFloor,
  }) = _Inputs;

  /// Reads inputs from a JSON map, using the defaults for missing values.
  factory Inputs.fromJson(Map<String, dynamic> json) => _$InputsFromJson(json);

  /// The trim on all four sides.
  Sides get trim =>
      Sides(top: trimTop, bottom: trimBottom, left: trimLeft, right: trimRight);

  /// The gap on all four sides.
  Sides get gap =>
      Sides(top: gapTop, bottom: gapBottom, left: gapLeft, right: gapRight);

  /// Distance from the framed opening's left edge to the window (trim plus
  /// gap).
  double get insetLeft => trimLeft + gapLeft;

  /// Distance from the framed opening's right edge to the window.
  double get insetRight => trimRight + gapRight;

  /// Distance from the framed opening's top edge to the window.
  double get insetTop => trimTop + gapTop;

  /// Distance from the framed opening's bottom edge to the window.
  double get insetBottom => trimBottom + gapBottom;

  /// Width of the framed opening the ring surrounds: the window plus its
  /// trim and gaps on the left and right.
  double get openW => windowW + insetLeft + insetRight;

  /// Height of the framed opening: the window plus its trim and gaps on the
  /// top and bottom.
  double get openH => windowH + insetTop + insetBottom;

  /// Width of the wall between the left and right margins, or null when no
  /// wall width is set. Never negative.
  double? get usableWallW {
    final w = wallW;
    if (w == null) return null;
    return (w - wallMarginLeft - wallMarginRight).clamp(0.0, double.infinity);
  }

  /// Distance from the wall's left edge to the window's left edge, or null
  /// when no wall width is set.
  ///
  /// Centered between the margins unless [windowFromWallLeft] is given. The
  /// framed opening (window plus gaps) is always kept between the margins.
  double? get windowLeftOnWall {
    final usable = usableWallW;
    if (usable == null) return null;
    final room = (usable - openW).clamp(0.0, double.infinity);
    final lo = wallMarginLeft + insetLeft;
    return (windowFromWallLeft ?? lo + room / 2).clamp(lo, lo + room);
  }

  /// Horizontal position of the ring's left edge on the wall, or null when no
  /// wall width is set.
  double? get effectiveRingOffset {
    final p = windowLeftOnWall;
    return p == null ? null : p - insetLeft - left;
  }

  /// Height of the wall below the top margin, or null when no wall height is
  /// set. Never negative.
  double? get usableWallH {
    final h = wallH;
    if (h == null) return null;
    return (h - wallMarginTop).clamp(0.0, double.infinity);
  }

  /// Distance from the floor to the window's bottom edge, or null when no wall
  /// height is set.
  ///
  /// Centered between the floor and the top margin unless [windowFromFloor]
  /// is given. The framed opening is always kept below the top margin.
  double? get windowBottomOnWall {
    final usable = usableWallH;
    if (usable == null) return null;
    final room = (usable - openH).clamp(0.0, double.infinity);
    return (windowFromFloor ?? insetBottom + room / 2).clamp(
      insetBottom,
      insetBottom + room,
    );
  }

  /// These inputs with the column widths and bar heights resolved.
  ///
  /// When [fillWall] is on, a wall width grows the columns so the ring runs
  /// from the left margin to the right margin, and a wall height grows the
  /// bars so the ring runs from the floor to the top margin. The window sits
  /// at [windowLeftOnWall] and [windowBottomOnWall]. Otherwise the inputs are
  /// returned unchanged.
  Inputs get resolved {
    if (!fillWall) return this;
    var r = this;
    final w = wallW;
    final px = windowLeftOnWall;
    if (w != null && px != null) {
      r = r.copyWith(
        left: (px - insetLeft - wallMarginLeft).clamp(0.0, double.infinity),
        right: (w - wallMarginRight - px - windowW - insetRight).clamp(
          0.0,
          double.infinity,
        ),
      );
    }
    final usable = usableWallH;
    final py = windowBottomOnWall;
    if (usable != null && py != null) {
      r = r.copyWith(
        bottom: (py - insetBottom).clamp(0.0, double.infinity),
        top: (usable - py - windowH - insetTop).clamp(0.0, double.infinity),
      );
    }
    return r;
  }
}
