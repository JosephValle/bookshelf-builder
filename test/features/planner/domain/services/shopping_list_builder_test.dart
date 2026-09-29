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
}
