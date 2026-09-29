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
        '"${p.name}",${p.qty},"${formatter.partLength(p)}","$width","${p.material.label}"',
      );
    }
    return b.toString();
  }
}
