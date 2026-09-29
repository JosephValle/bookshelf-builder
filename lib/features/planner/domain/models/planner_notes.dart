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
      'Attach with a continuous 3/4" plywood French cleat screwed into studs '
      '(studs every 16 in on center), one at the top and one at mid-height on '
      'each column, and anchor the unit against tipping.';
}
