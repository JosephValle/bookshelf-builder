import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';

/// Renders a plain-text summary of a plan for pasting into notes or messages.
class SummaryBuilder {
  /// Creates a builder.
  const SummaryBuilder({this.formatter = const InchesFormatter()});

  /// Inch formatting used throughout the summary.
  final InchesFormatter formatter;

  /// Returns the summary text.
  String build(Plan plan) {
    final f = formatter.format;
    final i = plan.inputs;
    final b = StringBuffer()
      ..writeln('Shelf Planner summary')
      ..writeln(
        'Ring: ${f(plan.ringW)} wide by ${f(plan.ringH)} tall, ${f(i.depth)} deep',
      )
      ..writeln('Window: ${f(i.windowW)} by ${f(i.windowH)}')
      ..writeln('Columns: left ${f(i.left)}, right ${f(i.right)}')
      ..writeln('Bars: top ${f(i.top)}, bottom ${f(i.bottom)}')
      ..writeln('Toe kick: ${i.onFloor ? f(i.toeKick) : 'none'}')
      ..writeln('Shelf span limit: ${f(plan.spanLimit)}')
      ..writeln()
      ..writeln('Cut list');
    for (final p in plan.parts) {
      final width = p.material == PartMaterial.edgeBand
          ? ''
          : ' x ${f(p.width)}';
      b.writeln(
        '${p.qty} x ${p.name}: ${formatter.partLength(p)}$width (${p.material.label})',
      );
    }
    b
      ..writeln()
      ..writeln(
        '3/4" plywood sheets: ${plan.sheets.sheets34} (${plan.sheets.neededStrips} strips, ${plan.sheets.stripsPerSheet} per sheet)',
      )
      ..writeln('1/4" plywood sheets: ${plan.sheets.backSheets} (approximate)');
    if (plan.issues.isNotEmpty) {
      b
        ..writeln()
        ..writeln('Warnings');
      for (final s in plan.issues) {
        b.writeln('- ${s.message}');
      }
    }
    b
      ..writeln()
      ..writeln(PlannerNotes.store)
      ..writeln(PlannerNotes.disclaimer);
    return b.toString();
  }
}
