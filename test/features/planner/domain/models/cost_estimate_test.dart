import 'package:bookshelf_builder/features/planner/domain/models/cost_estimate.dart';
import 'package:bookshelf_builder/features/planner/domain/models/cost_line.dart';
import 'package:bookshelf_builder/features/planner/domain/models/store_prices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const prices = StorePrices(store: 'Test');
  const a = CostLine(label: 'a', quantity: 2, unit: 'sheet', unitPrice: 10);
  const b = CostLine(label: 'b', quantity: 1, unit: 'sheet', unitPrice: 5.5);
  const c = CostLine(label: 'c', quantity: 4, unit: 'ft', unitPrice: null);

  group('CostEstimate', () {
    test('sums every line when all are priced', () {
      const e = CostEstimate(prices: prices, lines: [a, b]);
      expect(e.isComplete, isTrue);
      expect(e.subtotal, 25.5);
      expect(e.tax, 0);
      expect(e.total, 25.5);
      expect(e.missing, isEmpty);
    });

    test('has no total when a price is missing', () {
      const e = CostEstimate(prices: prices, lines: [a, c]);
      expect(e.isComplete, isFalse);
      expect(e.total, isNull);
      expect(e.missing, [c]);
    });

    test('the priced subtotal ignores missing lines', () {
      const e = CostEstimate(prices: prices, lines: [a, c]);
      expect(e.pricedSubtotal, 20);
    });

    test('tax is added to the subtotal', () {
      const e = CostEstimate(prices: prices, lines: [a, b], taxRate: 0.1);
      expect(e.subtotal, 25.5);
      expect(e.tax, closeTo(2.55, 1e-9));
      expect(e.total, closeTo(28.05, 1e-9));
    });

    test('an incomplete estimate has no subtotal, tax or total', () {
      const e = CostEstimate(prices: prices, lines: [a, c], taxRate: 0.1);
      expect(e.subtotal, isNull);
      expect(e.tax, isNull);
      expect(e.total, isNull);
    });

    test('tax rate is part of equality', () {
      const x = CostEstimate(prices: prices, lines: [a]);
      const y = CostEstimate(prices: prices, lines: [a], taxRate: 0.07);
      expect(x, isNot(y));
    });

    test('an empty estimate totals zero', () {
      const e = CostEstimate(prices: prices, lines: []);
      expect(e.total, 0);
    });
  });
}
