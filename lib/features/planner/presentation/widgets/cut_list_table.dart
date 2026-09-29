import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:flutter/material.dart';

/// The cut list as a table: part, quantity, length, width and material.
class CutListTable extends StatelessWidget {
  /// Creates the table for [plan].
  const CutListTable({required this.plan, super.key});

  /// Plan whose parts are listed.
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    const f = InchesFormatter();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Space.md),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: Space.lg,
          columns: const [
            DataColumn(label: Text('Part')),
            DataColumn(label: Text('Qty'), numeric: true),
            DataColumn(label: Text('Length')),
            DataColumn(label: Text('Width')),
            DataColumn(label: Text('Material')),
          ],
          rows: [
            for (final p in plan.parts)
              DataRow(
                cells: [
                  DataCell(Text(p.name)),
                  DataCell(Text('${p.qty}')),
                  DataCell(Text(f.partLength(p))),
                  DataCell(
                    Text(
                      p.material == PartMaterial.edgeBand
                          ? ''
                          : f.format(p.width),
                    ),
                  ),
                  DataCell(Text(p.material.label)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
