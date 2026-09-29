import 'package:equatable/equatable.dart';

/// Every value the user can change. Immutable; use [copyWith] to derive edits.
///
/// All lengths are in inches. The defaults describe a 48" square window with
/// 14" columns and bars on a 3.5" toe kick.
class Inputs extends Equatable {
  /// Creates inputs, defaulting to the standard starting layout.
  const Inputs({
    this.windowW = 48,
    this.windowH = 48,
    this.left = 14,
    this.right = 14,
    this.top = 14,
    this.bottom = 14,
    this.depth = 11.25,
    this.onFloor = true,
    this.toeKick = 3.5,
    this.targetClearH = 11,
    this.edgeStiffener = false,
    this.maxShelfWidth = 24,
    this.fillWall = true,
    this.wallW,
    this.wallH,
    this.wallMarginTop = 0,
    this.wallMarginLeft = 0,
    this.wallMarginRight = 0,
    this.windowFromWallLeft,
    this.windowFromFloor,
    this.gapTop = 0,
    this.gapBottom = 0,
    this.gapLeft = 0,
    this.gapRight = 0,
  });

  /// Window width (the glass or frame you are building around).
  final double windowW;

  /// Window height.
  final double windowH;

  /// Gap left between the window and the shelves above it (trim, casing).
  final double gapTop;

  /// Gap between the window and the shelves below it.
  final double gapBottom;

  /// Gap between the window and the left column.
  final double gapLeft;

  /// Gap between the window and the right column.
  final double gapRight;

  /// Width of the framed opening the ring surrounds: the window plus its
  /// left and right gaps.
  double get openW => windowW + gapLeft + gapRight;

  /// Height of the framed opening: the window plus its top and bottom gaps.
  double get openH => windowH + gapTop + gapBottom;

  /// Left column outer width.
  final double left;

  /// Right column outer width.
  final double right;

  /// Top bar height from ring top to window top.
  final double top;

  /// Bottom bar height from window bottom to ring bottom, including the kick.
  final double bottom;

  /// Total depth including the back panel.
  final double depth;

  /// Whether the ring sits on a toe kick on the floor.
  final bool onFloor;

  /// Toe kick height, used only when [onFloor] is true.
  final double toeKick;

  /// Desired shelf opening height in the columns.
  final double targetClearH;

  /// Whether a solid front edge band is added to horizontal panels.
  final bool edgeStiffener;

  /// Preferred maximum clear shelf width. Dividers are added whenever a bay
  /// would be wider, and it is capped by the structural span limits.
  final double maxShelfWidth;

  /// Whether the columns grow to fill the whole wall width when a wall width
  /// is set. When false the ring keeps its column widths and sits on the wall.
  final bool fillWall;

  /// Optional wall width.
  final double? wallW;

  /// Optional wall height (floor to ceiling) for fit checks.
  final double? wallH;

  /// Distance from the ceiling that the shelves must stay clear of (crown
  /// molding, a soffit). Used with [wallH].
  final double wallMarginTop;

  /// Distance from the wall's left edge that the shelves must stay clear of
  /// (a door, trim, an adjacent cabinet). Used with [wallW].
  final double wallMarginLeft;

  /// Distance from the wall's right edge that the shelves must stay clear of.
  /// Used with [wallW]. The bottom of the wall is the floor, so it has no
  /// margin.
  final double wallMarginRight;

  /// Optional distance from the wall's left edge to the window's left edge.
  /// Centered on the wall when unset.
  final double? windowFromWallLeft;

  /// Optional distance from the floor to the window's bottom edge. Centered
  /// between the floor and the top margin when unset.
  final double? windowFromFloor;

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
    final lo = wallMarginLeft + gapLeft;
    return (windowFromWallLeft ?? lo + room / 2).clamp(lo, lo + room);
  }

  /// Horizontal position of the ring's left edge on the wall, or null when no
  /// wall width is set.
  double? get effectiveRingOffset {
    final p = windowLeftOnWall;
    return p == null ? null : p - gapLeft - left;
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
    return (windowFromFloor ?? gapBottom + room / 2).clamp(
      gapBottom,
      gapBottom + room,
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
        left: (px - gapLeft - wallMarginLeft).clamp(0.0, double.infinity),
        right: (w - wallMarginRight - px - windowW - gapRight).clamp(
          0.0,
          double.infinity,
        ),
      );
    }
    final usable = usableWallH;
    final py = windowBottomOnWall;
    if (usable != null && py != null) {
      r = r.copyWith(
        bottom: (py - gapBottom).clamp(0.0, double.infinity),
        top: (usable - py - windowH - gapTop).clamp(0.0, double.infinity),
      );
    }
    return r;
  }

  /// Returns a copy with the given fields replaced.
  ///
  /// The optional wall fields take a callback so that they can be cleared:
  /// pass `() => null` to set one back to unset.
  Inputs copyWith({
    double? windowW,
    double? windowH,
    double? left,
    double? right,
    double? top,
    double? bottom,
    double? depth,
    bool? onFloor,
    double? toeKick,
    double? targetClearH,
    bool? edgeStiffener,
    double? maxShelfWidth,
    bool? fillWall,
    double? Function()? wallW,
    double? Function()? wallH,
    double? wallMarginTop,
    double? wallMarginLeft,
    double? wallMarginRight,
    double? Function()? windowFromWallLeft,
    double? Function()? windowFromFloor,
    double? gapTop,
    double? gapBottom,
    double? gapLeft,
    double? gapRight,
  }) {
    return Inputs(
      windowW: windowW ?? this.windowW,
      windowH: windowH ?? this.windowH,
      left: left ?? this.left,
      right: right ?? this.right,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      depth: depth ?? this.depth,
      onFloor: onFloor ?? this.onFloor,
      toeKick: toeKick ?? this.toeKick,
      targetClearH: targetClearH ?? this.targetClearH,
      edgeStiffener: edgeStiffener ?? this.edgeStiffener,
      maxShelfWidth: maxShelfWidth ?? this.maxShelfWidth,
      fillWall: fillWall ?? this.fillWall,
      wallW: wallW != null ? wallW() : this.wallW,
      wallH: wallH != null ? wallH() : this.wallH,
      wallMarginTop: wallMarginTop ?? this.wallMarginTop,
      wallMarginLeft: wallMarginLeft ?? this.wallMarginLeft,
      wallMarginRight: wallMarginRight ?? this.wallMarginRight,
      windowFromWallLeft: windowFromWallLeft != null
          ? windowFromWallLeft()
          : this.windowFromWallLeft,
      windowFromFloor: windowFromFloor != null
          ? windowFromFloor()
          : this.windowFromFloor,
      gapTop: gapTop ?? this.gapTop,
      gapBottom: gapBottom ?? this.gapBottom,
      gapLeft: gapLeft ?? this.gapLeft,
      gapRight: gapRight ?? this.gapRight,
    );
  }

  @override
  List<Object?> get props => [
    windowW,
    windowH,
    left,
    right,
    top,
    bottom,
    depth,
    onFloor,
    toeKick,
    targetClearH,
    edgeStiffener,
    maxShelfWidth,
    fillWall,
    wallW,
    wallH,
    windowFromWallLeft,
  ];
}
