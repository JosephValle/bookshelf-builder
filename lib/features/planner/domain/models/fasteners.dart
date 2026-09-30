/// Where fasteners go and how far apart they sit. All lengths are inches.
///
/// These are common woodworking rules of thumb for 3/4" plywood boxes, used by
/// the assembly guide, its diagrams and the fastener counts.
class Fasteners {
  const Fasteners._();

  /// Screw that joins the 3/4" plywood boxes: shelves, dividers, bars, toe kick.
  static const String boxScrew = '#8 x 1-1/4" cabinet screws';

  /// Screw for the unit half of the French cleat.
  static const String unitCleatScrew = '#8 x 2" cabinet screws';

  /// Screw for the wall half of the cleat on a stud wall.
  static const String studScrew = '#10 x 3" structural screws';

  /// Screw for the wall half of the cleat on a concrete wall.
  static const String concreteScrew = '3/16" x 2-1/4" concrete screws';

  /// Distance from the front and back edge of a panel to the first screw.
  static const double edgeInset = 1;

  /// Depth of panel above which a third, middle screw is added to a joint.
  static const double middleScrewDepth = 9;

  /// Largest spacing between screws along a long strip (the cleats).
  static const double screwSpacing = 6;

  /// Distance from the end of a cleat strip to its first screw.
  static const double cleatEndInset = 1;

  /// Distance from the edge of a cleat strip to a wall screw.
  static const double wallScrewEdgeInset = 1;

  /// Distance from the end of a cleat strip to its first concrete screw.
  static const double concreteEndInset = 1.5;

  /// Largest spacing between pairs of concrete screws along a cleat strip.
  static const double concreteSpacing = 12;

  /// Largest spacing between brads along a back panel.
  static const double nailSpacing = 6;

  /// Distance from the edge of a back panel to its brads.
  static const double nailInset = 0.375;

  /// Largest spacing between screws fastening the toe kick.
  static const double toeKickSpacing = 8;

  /// Screws in one joint of a panel that is [depth] deep.
  static int screwsPerJoint(double depth) => depth > middleScrewDepth ? 3 : 2;
}
