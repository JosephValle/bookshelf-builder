import 'package:bookshelf_builder/features/planner/domain/services/money_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const m = MoneyFormatter();

  group('format', () {
    test('two decimals', () => expect(m.format(69.85), r'$69.85'));
    test('pads cents', () => expect(m.format(5), r'$5.00'));
    test('pads single digit cents', () => expect(m.format(5.05), r'$5.05'));
    test('rounds to the cent', () => expect(m.format(1.005 + 1.0), r'$2.01'));
    test('groups thousands', () => expect(m.format(1234.5), r'$1,234.50'));
    test(
      'groups millions',
      () => expect(m.format(1234567.89), r'$1,234,567.89'),
    );
    test('zero', () => expect(m.format(0), r'$0.00'));
    test('negative', () => expect(m.format(-3.5), r'-$3.50'));
    test('tiny negatives round to zero without a sign', () {
      expect(m.format(-0.001), r'$0.00');
    });
  });
}
