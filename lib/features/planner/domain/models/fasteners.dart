/// Where fasteners go and how far apart they sit. All lengths are inches.
///
/// These are common woodworking rules of thumb for 3/4" plywood boxes, used by
/// the assembly guide, its diagrams and the fastener counts.
class Fasteners {
  const Fasteners._();

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

  /// Largest spacing between brads along a back panel.
  static const double nailSpacing = 6;

  /// Distance from the edge of a back panel to its brads.
  static const double nailInset = 0.375;

  /// Largest spacing between screws fastening the toe kick.
  static const double toeKickSpacing = 8;

  /// Screws in one joint of a panel that is [depth] deep.
  static int screwsPerJoint(double depth) => depth > middleScrewDepth ? 3 : 2;
}
