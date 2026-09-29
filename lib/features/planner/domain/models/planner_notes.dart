/// User-facing static notes shown in the app and in the exported PDF.
class PlannerNotes {
  const PlannerNotes._();

  /// Footer telling the user the limits are rules of thumb.
  static const String disclaimer =
      'These limits are rules of thumb, not engineering certification. '
      'Verify against your actual book load.';

  /// Reminder about in-store cutting services.
  static const String store =
      'Home Depot in-store panel cuts are limited and priced per cut. '
      'Stock sizes and availability vary by store.';

  /// How to attach the finished unit to the wall.
  static const String wall =
      'Attach with a 3/4" plywood French cleat: one half screwed into studs '
      '(studs every 16 in on center) and the matching half fastened to the '
      'back of the unit, one row at the top and one at mid-height on '
      'each column. Anchor the unit against tipping. Drive the anchors '
      'through the solid plywood anchor cleat inside the bar over the window '
      '(glued to the bar skins and webs), never through the 1/4" back panel '
      'alone.';

  /// How to attach the finished unit to a concrete or masonry wall.
  static const String wallConcrete =
      'Attach with a 3/4" plywood French cleat: one half fastened to the wall '
      'with 3/16" concrete screws (drilled with a hammer drill and a masonry '
      'bit into solid concrete or the face of a block, not into a mortar '
      'joint) and the matching half fastened to the back of the unit, one '
      'row at the top and one at mid-height on each column. Anchor the unit '
      'against tipping with concrete screws through the solid plywood anchor '
      'cleat inside the bar over the window, never through the 1/4" back '
      'panel alone. Follow the screw maker\'s instructions for hole size, '
      'depth and load, and use sleeve or hollow-wall anchors in hollow '
      'block.';

  /// The wall attachment note for a stud wall or, when [concrete] is true, a
  /// concrete or masonry wall.
  static String wallFor({required bool concrete}) =>
      concrete ? wallConcrete : wall;
}
