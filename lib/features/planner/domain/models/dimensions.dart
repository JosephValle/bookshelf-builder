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
  });

  /// Derives dimensions from [i].
  factory Dimensions.from(Inputs i) {
    final ringW = i.left + i.windowW + i.right;
    final ringH = i.top + i.windowH + i.bottom;
    final kick = i.onFloor ? i.toeKick : 0.0;
    return Dimensions(
      ringW: ringW,
      ringH: ringH,
      depthPanel: i.depth - Limits.backT,
      kick: kick,
      sideH: ringH - kick - 2 * Limits.t,
      spanLimit: i.edgeStiffener
          ? Limits.maxShelfSpanStiffened
          : Limits.maxShelfSpan,
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

  /// Active maximum clear shelf span.
  final double spanLimit;

  @override
  List<Object?> get props => [ringW, ringH, depthPanel, kick, sideH, spanLimit];
}
