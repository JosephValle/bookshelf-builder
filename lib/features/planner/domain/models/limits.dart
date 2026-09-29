/// Physical and structural constants used by the planner.
///
/// All lengths are in inches. The structural limits are rules of thumb for
/// 3/4" sanded plywood, not engineering certification.
class Limits {
  const Limits._();

  /// Actual thickness of 3/4" sanded plywood (23/32").
  static const double t = 0.71875;

  /// Actual thickness of 1/4" plywood (7/32"), used for the back panels.
  static const double backT = 0.21875;

  /// Width of a standard plywood sheet.
  static const double sheetW = 48;

  /// Length of a standard plywood sheet.
  static const double sheetL = 96;

  /// Width of material removed by one saw cut.
  static const double kerf = 0.125;

  /// Max clear span of a 3/4" shelf under books with a bare front edge.
  static const double maxShelfSpan = 30;

  /// Max clear span of a shelf with a solid front edge band.
  static const double maxShelfSpanStiffened = 36;

  /// Max clear spacing of vertical dividers in a bar that spans the window.
  static const double boxBeamMaxWebSpacing = 24;

  /// Widest window the bars can span without added support.
  static const double maxWindowSpan = 60;

  /// Smallest allowed clear bay width.
  static const double minClearW = 8;

  /// Smallest allowed clear bay height.
  static const double minClearH = 7.5;

  /// Smallest allowed column width or bar height (`minClearW + 2 * t`).
  static const double minOuterSection = 9.4375;

  /// Smallest allowed depth (an actual 1x8 board).
  static const double minDepth = 7.25;

  /// Largest depth accepted by the depth input.
  static const double maxDepth = 16;

  /// Wall stud spacing quoted in the attachment note.
  static const double studSpacing = 16;

  /// Ceiling clearance below which a warning is raised.
  static const double ceilingClearanceMin = 0.25;

  /// Usable fraction of a 1/4" sheet after cutting the back panels.
  static const double backYield = 0.85;
}
