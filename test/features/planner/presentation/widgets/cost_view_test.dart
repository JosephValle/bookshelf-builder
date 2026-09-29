import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cost_estimator.dart';
import 'package:bookshelf_builder/features/planner/domain/services/money_formatter.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/cost_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const money = MoneyFormatter();

  Future<void> pump(WidgetTester tester, Inputs i) {
    tester.view.physicalSize = const Size(800, 3000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: CostView(plan: planFor(i))),
        ),
      ),
    );
  }

  group('CostView', () {
    testWidgets('shows the ZIP and the update date as chips', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text('ZIP 33713'), findsOneWidget);
      expect(find.text('Updated ${PriceCatalog.updated}'), findsOneWidget);
      expect(find.byType(Chip), findsNWidgets(2));
    });

    testWidgets('has the card title and the store name', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text('Estimated cost'), findsOneWidget);
      expect(find.text("Lowe's estimate"), findsOneWidget);
    });

    testWidgets('shows one row per panel with quantity and unit price', (
      tester,
    ) async {
      await pump(tester, const Inputs());
      final plan = planFor();
      expect(find.text('3/4" sanded poplar plywood, 4x8'), findsOneWidget);
      expect(find.text('1/4" sanded Douglas fir plywood, 4x8'), findsOneWidget);
      expect(
        find.text('${plan.sheets.sheets34} sheet x ${money.format(69.85)}'),
        findsOneWidget,
      );
      expect(
        find.text('${plan.sheets.backSheets} sheet x ${money.format(35.01)}'),
        findsOneWidget,
      );
    });

    testWidgets('shows the line totals', (tester) async {
      await pump(tester, const Inputs());
      final est = const CostEstimator().estimate(planFor(), PriceCatalog.lowes);
      for (final l in est.lines) {
        expect(find.text(money.format(l.total!)), findsWidgets);
      }
    });

    testWidgets('shows the estimated subtotal, tax and total', (tester) async {
      await pump(tester, const Inputs());
      final est = const CostEstimator().estimate(planFor(), PriceCatalog.lowes);
      expect(find.text('Estimated subtotal'), findsOneWidget);
      expect(find.text('Estimated sales tax (7%)'), findsOneWidget);
      expect(find.text('Estimated total'), findsOneWidget);
      expect(find.text(money.format(est.subtotal!)), findsWidgets);
      expect(find.text(money.format(est.tax!)), findsWidgets);
      expect(find.text(money.format(est.total!)), findsWidgets);
    });

    testWidgets('the total is the subtotal plus tax', (tester) async {
      final est = const CostEstimator().estimate(planFor(), PriceCatalog.lowes);
      expect(est.total, closeTo(est.subtotal! + est.tax!, 1e-9));
      expect(est.subtotal, greaterThan(0));
    });

    testWidgets('the total row is emphasized', (tester) async {
      await pump(tester, const Inputs());
      final total = tester.widget<Text>(find.text('Estimated total'));
      final subtotal = tester.widget<Text>(find.text('Estimated subtotal'));
      expect(total.style!.fontWeight, FontWeight.w600);
      expect(total.style!.fontSize!, greaterThan(subtotal.style!.fontSize!));
    });

    testWidgets('never shows an empty or missing price', (tester) async {
      await pump(tester, const Inputs(edgeStiffener: true));
      expect(find.textContaining('no price found'), findsNothing);
      expect(find.textContaining('price not found'), findsNothing);
    });

    testWidgets('includes edge band when enabled', (tester) async {
      await pump(tester, const Inputs());
      expect(find.textContaining('Edge band'), findsNothing);
      await pump(tester, const Inputs(edgeStiffener: true));
      expect(find.text('Edge band ripped from 3/4" plywood'), findsOneWidget);
    });

    testWidgets('shows the disclaimer note', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text(PriceCatalog.note), findsOneWidget);
    });
  });
}
