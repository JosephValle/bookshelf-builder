import 'package:bookshelf_builder/features/planner/data/services/pdf_material_sections.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cost_estimator.dart';
import 'package:bookshelf_builder/features/planner/domain/services/money_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/tool_recommender.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pdf_text.dart';
import '../../support/plan_helpers.dart';

void main() {
  const sections = PdfMaterialSections();
  const money = MoneyFormatter();

  Future<String> textFor([Inputs i = const Inputs()]) async =>
      pdfText(await renderWidgets(sections.all(planFor(i))));

  group('all', () {
    test('returns the six cards', () {
      expect(sections.all(planFor()).length, 6);
    });

    test('renders every card title', () async {
      final text = await textFor();
      for (final title in [
        'Plywood',
        'Estimated cost',
        'Supplies to buy',
        'Recommended tools',
        'Buying',
        'Wall attachment',
      ]) {
        expect(text, contains(title), reason: title);
      }
    });
  });

  group('plywood', () {
    test('lists both sheet types with counts', () async {
      final p = planFor();
      final text = await textFor();
      expect(text, contains('3/4" plywood'));
      expect(text, contains('1/4" plywood'));
      expect(text, contains('${p.sheets.neededStrips} strips of'));
      expect(text, contains('Back panels, approximate'));
    });

    test('shows edge band only when enabled', () async {
      expect(await textFor(), isNot(contains('Front edge band')));
      final text = await textFor(const Inputs(edgeStiffener: true));
      expect(text, contains('Front edge band'));
      expect(text, contains('linear feet'));
    });
  });

  group('cost', () {
    test('shows the chips, store, subtotal, tax and total', () async {
      final text = await textFor();
      final est = const CostEstimator().estimate(planFor(), PriceCatalog.lowes);
      expect(text, contains('ZIP 33713'));
      expect(text, contains('Updated ${PriceCatalog.updated}'));
      expect(text, contains("Lowe's estimate"));
      expect(text, contains('Estimated subtotal'));
      expect(text, contains('Estimated sales tax (7%)'));
      expect(text, contains('Estimated total'));
      expect(text, contains(money.format(est.subtotal!)));
      expect(text, contains(money.format(est.tax!)));
      expect(text, contains(money.format(est.total!)));
    });

    test('shows each line with its unit price and total', () async {
      final text = await textFor();
      expect(text, contains('3/4" sanded poplar plywood, 4x8'));
      expect(text, contains('x ${money.format(69.85)}'));
      expect(text, contains('x ${money.format(35.01)}'));
    });

    test('includes the price note', () async {
      expect(await textFor(), contains('Reference prices for ZIP 33713'));
    });

    test('prices edge band when enabled', () async {
      final text = await textFor(const Inputs(edgeStiffener: true));
      expect(text, contains('Edge band ripped from 3/4" plywood'));
      expect(text, isNot(contains('no price found')));
    });
  });

  group('tools', () {
    test('lists every recommended tool with its reason', () async {
      final text = await textFor();
      for (final t in const ToolRecommender().recommend(planFor())) {
        expect(text, contains(t.name.split(' ').first), reason: t.name);
      }
      expect(text, contains('Locates studs'));
    });

    test('marks optional tools with a badge', () async {
      expect(await textFor(), contains('Optional'));
    });
  });

  group('notes', () {
    test('includes the buying and wall attachment notes', () async {
      final text = await textFor();
      expect(text, contains('in-store panel cuts'));
      expect(text, contains('French cleat'));
      expect(PlannerNotes.wall, isNotEmpty);
    });
  });

  test('every variant renders without throwing', () async {
    for (final i in [
      const Inputs(),
      const Inputs(edgeStiffener: true),
      const Inputs(onFloor: false),
      const Inputs(windowW: 70, left: 8),
      const Inputs(wallW: 120, wallH: 96),
    ]) {
      expect(await textFor(i), isNotEmpty);
    }
  });
}
