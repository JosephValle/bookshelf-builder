import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';

/// Packs part lengths into ripped plywood strips.
class StripPacker {
  /// Creates a packer.
  const StripPacker();

  /// Number of full length strips needed for [lengths].
  ///
  /// Uses first-fit-decreasing and adds one saw kerf after every part.
  int pack(List<double> lengths) {
    final sorted = [...lengths]..sort((a, b) => b.compareTo(a));
    final strips = <double>[];
    for (final len in sorted) {
      final cost = len + Limits.kerf;
      var placed = false;
      for (var k = 0; k < strips.length; k++) {
        if (strips[k] + cost <= Limits.sheetL + Limits.kerf + 1e-9) {
          strips[k] += cost;
          placed = true;
          break;
        }
      }
      if (!placed) strips.add(cost);
    }
    return strips.length;
  }
}
