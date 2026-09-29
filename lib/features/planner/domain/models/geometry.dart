import 'package:bookshelf_builder/features/planner/domain/models/bay.dart';
import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'geometry.freezed.dart';

/// Drawable layout of the ring: every panel, bay and the window.
@freezed
abstract class Geometry with _$Geometry {
  /// Creates a geometry.
  const factory Geometry({
    /// Every 3/4" panel seen from the front.
    required List<Box> panels,

    /// The part name of each entry of [panels], in the same order, for example
    /// `Left column shelf`. It lets the guide put a piece id on every panel.
    required List<String> panelNames,

    /// The toe kick, or null when the ring is not on the floor.
    required Box? toeKickBox,

    /// Every clear bay.
    required List<Bay> bays,

    /// The window itself.
    required Box windowBox,

    /// The framed opening the ring surrounds: the window plus trim and gaps.
    required Box openingBox,

    /// The window plus its trim (the opening without the gaps).
    required Box trimBox,
  }) = _Geometry;
}
