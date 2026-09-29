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
  });

  /// Clear window opening width.
  final double windowW;

  /// Clear window opening height.
  final double windowH;

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
  /// Centered between the margins unless [windowFromWallLeft] is given, and
  /// always kept between the margins.
  double? get windowLeftOnWall {
    final usable = usableWallW;
    if (usable == null) return null;
    final room = (usable - windowW).clamp(0.0, double.infinity);
    final p = (windowFromWallLeft ?? wallMarginLeft + room / 2).clamp(
      wallMarginLeft,
      wallMarginLeft + room,
    );
    return p;
  }

  /// Horizontal position of the ring's left edge on the wall, or null when no
  /// wall width is set.
  double? get effectiveRingOffset {
    final p = windowLeftOnWall;
    return p == null ? null : p - left;
  }

  /// These inputs with the column widths resolved.
  ///
  /// When a wall width is set and [fillWall] is on, the columns grow so the
  /// ring runs from the left margin to the right margin, with the window at
  /// [windowLeftOnWall]. Otherwise the inputs are returned unchanged.
  Inputs get resolved {
    final w = wallW;
    final p = windowLeftOnWall;
    if (w == null || p == null || !fillWall) return this;
    final leftW = (p - wallMarginLeft).clamp(0.0, double.infinity);
    final rightW = (w - wallMarginRight - p - windowW).clamp(
      0.0,
      double.infinity,
    );
    return copyWith(left: leftW, right: rightW);
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
