import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sides.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cost_estimator.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/money_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/tool_recommender.dart';

/// Renders a plain-text summary of a plan for pasting into notes or messages.
class SummaryBuilder {
  /// Creates a builder.
  const SummaryBuilder({
    this.formatter = const InchesFormatter(),
    this.estimator = const CostEstimator(),
    this.money = const MoneyFormatter(),
  });

  /// Inch formatting used throughout the summary.
  final InchesFormatter formatter;

  /// Prices the plan at each store.
  final CostEstimator estimator;

  /// Dollar formatting for the cost lines.
  final MoneyFormatter money;

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
      ..writeln(_sides('Trim around window', i.trim))
      ..writeln(_sides('Gaps around window', i.gap))
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
        '${p.idRange}: ${p.qty} x ${p.name}: ${formatter.partLength(p)}$width (${p.material.label})',
      );
    }
    b
      ..writeln()
      ..writeln(
        '3/4" plywood sheets: ${plan.sheets.sheets34} (${plan.sheets.neededStrips} strips, ${plan.sheets.stripsPerSheet} per sheet)',
      )
      ..writeln('1/4" plywood sheets: ${plan.sheets.backSheets} (approximate)');
    b
      ..writeln()
      ..writeln('Recommended tools');
    for (final t in const ToolRecommender().recommend(plan)) {
      b.writeln('- ${t.essential ? t.name : '${t.name} (optional)'}');
    }
    b
      ..writeln()
      ..writeln(
        'Estimated cost (ZIP ${PriceCatalog.zip}, prices updated ${PriceCatalog.updated})',
      );
    for (final store in PriceCatalog.stores) {
      final est = estimator.estimate(plan, store);
      b.writeln(
        est.isComplete
            ? '${store.store} estimate: ${money.format(est.total!)}'
            : '${store.store}: price not found',
      );
      for (final l in est.lines.where((l) => l.unitPrice != null)) {
        b.writeln(
          '  ${l.quantity.toStringAsFixed(0)} x ${l.label} at ${money.format(l.unitPrice!)} = ${money.format(l.total!)}',
        );
      }
      if (est.subtotal != null) {
        b
          ..writeln('  Estimated subtotal: ${money.format(est.subtotal!)}')
          ..writeln(
            '  Estimated sales tax (${(est.taxRate * 100).toStringAsFixed(0)}%): ${money.format(est.tax!)}',
          )
          ..writeln('  Estimated total: ${money.format(est.total!)}');
      }
    }
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

  String _sides(String label, Sides s) {
    if (s == const Sides()) return '$label: none';
    final f = formatter.format;
    return '$label: top ${f(s.top)}, bottom ${f(s.bottom)}, left ${f(s.left)}, right ${f(s.right)}';
  }
}
