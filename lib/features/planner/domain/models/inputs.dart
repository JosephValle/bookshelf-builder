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
    this.wallW,
    this.wallH,
    this.ringOffsetFromLeft,
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

  /// Optional wall width for fit checks.
  final double? wallW;

  /// Optional wall height (floor to ceiling) for fit checks.
  final double? wallH;

  /// Optional horizontal position of the ring on the wall.
  final double? ringOffsetFromLeft;

  /// Horizontal position of the ring's left edge on the wall, or null when no
  /// wall width is set.
  ///
  /// Uses [ringOffsetFromLeft] when given. Otherwise the window is centered on
  /// the wall, which differs from centering the whole ring when the two
  /// columns are different widths.
  double? get effectiveRingOffset {
    final w = wallW;
    if (w == null) return null;
    return ringOffsetFromLeft ?? w / 2 - left - windowW / 2;
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
    double? Function()? wallW,
    double? Function()? wallH,
    double? Function()? ringOffsetFromLeft,
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
      wallW: wallW != null ? wallW() : this.wallW,
      wallH: wallH != null ? wallH() : this.wallH,
      ringOffsetFromLeft: ringOffsetFromLeft != null
          ? ringOffsetFromLeft()
          : this.ringOffsetFromLeft,
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
    wallW,
    wallH,
    ringOffsetFromLeft,
  ];
}
