import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PriceCatalog', () {
    test('is tagged with the ZIP code and the update date', () {
      expect(PriceCatalog.zip, '33713');
      expect(PriceCatalog.updated, matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
      expect(PriceCatalog.note, contains('33713'));
      expect(PriceCatalog.note, contains(PriceCatalog.updated));
    });

    test('has at least one store', () {
      expect(PriceCatalog.stores, isNotEmpty);
    });

    test('no shown store has an empty sheet price', () {
      for (final s in PriceCatalog.stores) {
        expect(s.sheet34, isNotNull, reason: '${s.store} 3/4"');
        expect(s.sheet14, isNotNull, reason: '${s.store} 1/4"');
        expect(s.sheet34, greaterThan(0));
        expect(s.sheet14, greaterThan(0));
      }
    });

    test('a 3/4 inch sheet costs more than a 1/4 inch sheet', () {
      for (final s in PriceCatalog.stores) {
        expect(s.sheet34, greaterThan(s.sheet14!));
      }
    });

    test('Lowe\'s carries the verified listing prices', () {
      expect(PriceCatalog.lowes.sheet34, 69.85);
      expect(PriceCatalog.lowes.sheet14, 35.01);
    });

    test('the note says where the prices came from and what is missing', () {
      expect(PriceCatalog.note, contains('lowes.com'));
      expect(PriceCatalog.note, contains('Home'));
      expect(PriceCatalog.note, contains('edge band'));
    });

    test('the note contains no em dash', () {
      expect(PriceCatalog.note.contains('—'), isFalse);
    });

    test('the sales tax rate is a sensible fraction', () {
      expect(PriceCatalog.salesTaxRate, greaterThan(0));
      expect(PriceCatalog.salesTaxRate, lessThan(0.15));
      expect(PriceCatalog.note, contains('sales tax'));
    });
  });
}
