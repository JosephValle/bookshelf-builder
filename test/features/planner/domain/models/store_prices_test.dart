import 'package:bookshelf_builder/features/planner/domain/models/store_prices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StorePrices', () {
    test('prices default to unknown', () {
      const p = StorePrices(store: 'Test');
      expect(p.sheet34, isNull);
      expect(p.sheet14, isNull);
      expect(p.edgeBandPerFoot, isNull);
    });

    test('has value equality', () {
      expect(
        const StorePrices(store: 'A', sheet34: 1),
        const StorePrices(store: 'A', sheet34: 1),
      );
      expect(
        const StorePrices(store: 'A', sheet34: 1),
        isNot(const StorePrices(store: 'A', sheet34: 2)),
      );
    });
  });
}
