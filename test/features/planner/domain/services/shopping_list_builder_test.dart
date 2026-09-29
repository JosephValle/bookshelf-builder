import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/shopping_list_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('ShoppingListBuilder', () {
    test('lists materials and tools with quantities from the plan', () {
      final items = const ShoppingListBuilder().build(planFor());
      expect(items.where((i) => !i.isTool), isNotEmpty);
      expect(items.where((i) => i.isTool), isNotEmpty);
      expect(items.firstWhere((i) => i.id == 'glue').quantity, greaterThan(0));
    });

    test('an unrecorded price stays null instead of being guessed', () {
      final items = const ShoppingListBuilder(prices: {}).build(planFor());
      expect(items.every((i) => i.unitPrice == null), isTrue);
      expect(items.every((i) => i.total == null), isTrue);
    });

    test('a recorded price is used for the total', () {
      final items = const ShoppingListBuilder(prices: {'clamps': 10})
          .build(planFor());
      final clamps = items.firstWhere((i) => i.id == 'clamps');
      expect(clamps.total, 10 * clamps.quantity);
    });

    test('shims are only listed for a unit on the floor', () {
      final floor = const ShoppingListBuilder().build(planFor());
      final hung = const ShoppingListBuilder().build(
        planFor(const Inputs(onFloor: false)),
      );
      expect(floor.any((i) => i.id == 'shims'), isTrue);
      expect(hung.any((i) => i.id == 'shims'), isFalse);
    });
  });

  group('concrete wall', () {
    final stud = const ShoppingListBuilder().build(planFor());
    final concrete = const ShoppingListBuilder().build(
      planFor(const Inputs(concreteWall: true)),
    );

    test('a stud wall lists structural screws and a stud finder', () {
      expect(stud.any((i) => i.id == 'screws-structural'), isTrue);
      expect(stud.any((i) => i.id == 'stud-finder'), isTrue);
      expect(stud.any((i) => i.id == 'hammer-drill'), isFalse);
    });

    test('a concrete wall lists concrete screws and masonry tools', () {
      expect(concrete.any((i) => i.id == 'screws-concrete'), isTrue);
      expect(concrete.any((i) => i.id == 'hammer-drill'), isTrue);
      expect(concrete.any((i) => i.id == 'blowout'), isTrue);
      expect(concrete.any((i) => i.id == 'screws-structural'), isFalse);
      expect(concrete.any((i) => i.id == 'stud-finder'), isFalse);
    });

    test('concrete items have no invented price', () {
      for (final id in ['screws-concrete', 'hammer-drill', 'blowout']) {
        expect(concrete.firstWhere((i) => i.id == id).unitPrice, isNull);
      }
    });
  });
}
