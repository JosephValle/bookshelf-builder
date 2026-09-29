import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';

/// Formats inch values as fractions to the nearest 1/16 (for example `11 1/4"`).
class InchesFormatter {
  /// Creates a formatter.
  const InchesFormatter();

  /// Formats [v] with a trailing inch mark, e.g. `11 1/4"`, `3/4"` or `0"`.
  String format(double v) {
    final sixteenths = (v.abs() * 16).round();
    final whole = sixteenths ~/ 16;
    var num = sixteenths % 16;
    var den = 16;
    while (num != 0 && num.isEven) {
      num ~/= 2;
      den ~/= 2;
    }
    final sign = v < 0 && sixteenths != 0 ? '-' : '';
    if (num == 0) return '$sign$whole"';
    if (whole == 0) return '$sign$num/$den"';
    return '$sign$whole $num/$den"';
  }

  /// Same as [format] without the inch mark, for text fields.
  String plain(double v) => format(v).replaceAll('"', '');

  /// Length text for a cut list line: an inch fraction, or feet for edge band.
  String partLength(Part p) {
    if (p.material == PartMaterial.edgeBand) {
      return '${(p.length / 12).toStringAsFixed(1)} ft';
    }
    return format(p.length);
  }
}
