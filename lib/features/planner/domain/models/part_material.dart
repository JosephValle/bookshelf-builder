/// Material a [Part] is cut from.
enum PartMaterial {
  /// 3/4" sanded plywood.
  ply34('3/4" plywood'),

  /// 1/4" plywood, used for back panels.
  ply14('1/4" plywood'),

  /// Solid front edge band, measured in total length.
  edgeBand('edge band');

  const PartMaterial(this.label);

  /// Display name.
  final String label;
}
