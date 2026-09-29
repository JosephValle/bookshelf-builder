import 'package:bookshelf_builder/features/planner/domain/models/bay.dart';
import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:equatable/equatable.dart';

/// Drawable layout of the ring: every panel, bay and the window.
class Geometry extends Equatable {
  /// Creates a geometry.
  const Geometry({
    required this.panels,
    required this.toeKickBox,
    required this.bays,
    required this.windowBox,
  });

  /// Every 3/4" panel seen from the front.
  final List<Box> panels;

  /// The toe kick, or null when the ring is not on the floor.
  final Box? toeKickBox;

  /// Every clear bay.
  final List<Bay> bays;

  /// The window opening.
  final Box windowBox;

  @override
  List<Object?> get props => [panels, toeKickBox, bays, windowBox];
}
