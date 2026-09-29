import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:equatable/equatable.dart';

/// Values derived from [Inputs] that the rest of the engine relies on.
class Dimensions extends Equatable {
  /// Creates dimensions directly (mainly for tests).
  const Dimensions({
    required this.ringW,
    required this.ringH,
    required this.depthPanel,
    required this.kick,
    required this.sideH,
    required this.spanLimit,
    required this.shelfWidth,
  });

  /// Derives dimensions from [i].
  factory Dimensions.from(Inputs i) {
    final ringW = i.left + i.openW + i.right;
    final ringH = i.top + i.openH + i.bottom;
    final kick = i.onFloor ? i.toeKick : 0.0;
    final span = i.edgeStiffener
        ? Limits.maxShelfSpanStiffened
        : Limits.maxShelfSpan;
    return Dimensions(
      ringW: ringW,
      ringH: ringH,
      depthPanel: i.depth - Limits.backT,
      kick: kick,
      sideH: ringH - kick - 2 * Limits.t,
      spanLimit: span,
      shelfWidth: i.maxShelfWidth < span ? i.maxShelfWidth : span,
    );
  }

  /// Overall ring width.
  final double ringW;

  /// Overall ring height.
  final double ringH;

  /// Depth of every 3/4" panel (total depth minus the back panel).
  final double depthPanel;

  /// Toe kick height, zero when not on the floor.
  final double kick;

  /// Length of the vertical column panels.
  final double sideH;

  /// Active structural maximum clear shelf span (30 in, or 36 in with the
  /// edge band).
  final double spanLimit;

  /// Widest shelf bay the planner will allow: the preferred maximum shelf
  /// width, capped by [spanLimit].
  final double shelfWidth;

  @override
  List<Object?> get props => [
    ringW,
    ringH,
    depthPanel,
    kick,
    sideH,
    spanLimit,
    shelfWidth,
  ];
}
