import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/supplies_cost_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('SuppliesCostView', () {
    testWidgets('lists supplies and tools with a checkbox per tool', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 4000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: SuppliesCostView(plan: planFor(const Inputs())),
            ),
          ),
        ),
      );
      expect(find.text('Wood glue, 16 oz'), findsOneWidget);
      expect(find.text('Stud finder'), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsWidgets);
      final box = find.byType(CheckboxListTile).first;
      await tester.tap(box);
      await tester.pump();
      expect(tester.widget<CheckboxListTile>(box).value, isTrue);
      expect(find.text('owned'), findsOneWidget);
    });
  });
}
