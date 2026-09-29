import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';

/// Renders the cut list as CSV text.
class CutListCsvBuilder {
  /// Creates a builder.
  const CutListCsvBuilder({this.formatter = const InchesFormatter()});

  /// Inch formatting used for lengths and widths.
  final InchesFormatter formatter;

  /// Returns a header row followed by one row per part.
  String build(Plan plan) {
    final b = StringBuffer('Part,Qty,Length,Width,Material\n');
    for (final p in plan.parts) {
      final width = p.material == PartMaterial.edgeBand
          ? ''
          : formatter.format(p.width);
      b.writeln(
        [
          _quote(p.name),
          '${p.qty}',
          _quote(formatter.partLength(p)),
          _quote(width),
          _quote(p.material.label),
        ].join(','),
      );
    }
    return b.toString();
  }

  /// Wraps [value] in quotes and doubles any embedded quote, so inch marks
  /// such as `76"` survive as valid CSV.
  String _quote(String value) => '"${value.replaceAll('"', '""')}"';
}
