import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dimensions.freezed.dart';

/// Values derived from [Inputs] that the rest of the engine relies on.
@freezed
abstract class Dimensions with _$Dimensions {
  const Dimensions._();

  /// Creates dimensions directly (mainly for tests).
  const factory Dimensions({
    /// Overall ring width.
    required double ringW,

    /// Overall ring height.
    required double ringH,

    /// Depth of every 3/4" panel (total depth minus the back panel).
    required double depthPanel,

    /// Toe kick height, zero when not on the floor.
    required double kick,

    /// Length of the vertical column panels.
    required double sideH,

    /// Active structural maximum clear shelf span (30 in, or 36 in with the
    /// edge band).
    required double spanLimit,

    /// Widest shelf bay the planner will allow: the preferred maximum shelf
    /// width, capped by the span limit.
    required double shelfWidth,
  }) = _Dimensions;

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
}
