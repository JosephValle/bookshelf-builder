/// What a diagram shape represents, which decides how it is colored.
enum DiagramTone {
  /// A 3/4" plywood part.
  panel,

  /// A 1/4" plywood back.
  back,

  /// A cleat strip.
  cleat,

  /// The wall.
  wall,

  /// A part shown only for reference, drawn faintly.
  ghost,
}
