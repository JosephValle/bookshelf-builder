import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/models/store_prices.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cost_estimator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const estimator = CostEstimator();
  const prices = StorePrices(store: 'Test', sheet34: 60, sheet14: 30);

  group('estimate', () {
    test('has one line per panel type', () {
      final e = estimator.estimate(planFor(), prices);
      expect(e.lines.length, 2);
      expect(e.lines[0].unit, 'sheet');
      expect(e.lines[1].unit, 'sheet');
    });

    test('quantities come from the sheet estimate', () {
      final p = planFor();
      final e = estimator.estimate(p, prices);
      expect(e.lines[0].quantity, p.sheets.sheets34);
      expect(e.lines[1].quantity, p.sheets.backSheets);
    });

    test('the subtotal is sheets times price', () {
      final p = planFor();
      final e = estimator.estimate(p, prices);
      expect(e.subtotal, p.sheets.sheets34 * 60 + p.sheets.backSheets * 30);
    });

    test('tax is the catalog rate on the subtotal', () {
      final e = estimator.estimate(planFor(), prices);
      expect(e.taxRate, PriceCatalog.salesTaxRate);
      expect(e.tax, closeTo(e.subtotal! * 0.07, 1e-9));
      expect(e.total, closeTo(e.subtotal! * 1.07, 1e-9));
    });

    test('a custom tax rate is used', () {
      const noTax = CostEstimator(taxRate: 0);
      final e = noTax.estimate(planFor(), prices);
      expect(e.tax, 0);
      expect(e.total, e.subtotal);
    });

    test('a bigger plan costs more', () {
      final small = estimator.estimate(planFor(), prices).subtotal!;
      final big = estimator
          .estimate(planFor(const Inputs(windowW: 60, windowH: 60)), prices)
          .subtotal!;
      expect(big, greaterThanOrEqualTo(small));
    });

    test('an unknown price leaves the line unpriced', () {
      final e = estimator.estimate(
        planFor(),
        const StorePrices(store: 'X', sheet34: 60),
      );
      expect(e.isComplete, isFalse);
      expect(e.total, isNull);
      expect(e.subtotal, isNull);
      expect(e.tax, isNull);
      expect(e.missing.single.unitPrice, isNull);
    });

    test('no edge band line without the stiffener', () {
      final e = estimator.estimate(planFor(), prices);
      expect(e.lines.any((l) => l.unit == 'ft'), isFalse);
    });

    test('edge band is costed from the sheet when it has no own price', () {
      final p = planFor(const Inputs(edgeStiffener: true));
      final e = estimator.estimate(p, prices);
      final band = e.lines.last;
      expect(band.unit, 'ft');
      expect(band.label, contains('ripped'));
      expect(band.quantity, (p.edgeBandInches / 12).ceilToDouble());
      expect(band.unitPrice, closeTo(60 / 440, 1e-9));
      expect(e.isComplete, isTrue);
    });

    test('an explicit edge band price wins', () {
      final e = estimator.estimate(
        planFor(const Inputs(edgeStiffener: true)),
        const StorePrices(
          store: 'X',
          sheet34: 60,
          sheet14: 30,
          edgeBandPerFoot: 2,
        ),
      );
      expect(e.lines.last.unitPrice, 2);
      expect(e.lines.last.label, 'Solid edge band');
    });

    test('every shown store prices every line, with and without edge band', () {
      for (final s in PriceCatalog.stores) {
        for (final i in [const Inputs(), const Inputs(edgeStiffener: true)]) {
          final e = estimator.estimate(planFor(i), s);
          expect(e.isComplete, isTrue, reason: '${s.store} ${i.edgeStiffener}');
          expect(e.total, greaterThan(0));
        }
      }
    });
  });

  group('ripCostPerFoot', () {
    test('a sheet yields 55 strips of 8 feet', () {
      expect(estimator.ripCostPerFoot(44), closeTo(44 / 440, 1e-9));
    });

    test('is null without a sheet price', () {
      expect(estimator.ripCostPerFoot(null), isNull);
    });
  });
}
