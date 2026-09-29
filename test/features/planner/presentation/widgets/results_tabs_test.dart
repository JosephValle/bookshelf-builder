import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/results_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('ResultsTabs', () {
    testWidgets('switches between cut list, materials and warnings', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResultsTabs(plan: planFor(const Inputs(left: 8))),
          ),
        ),
      );
      expect(find.text('Top panel'), findsOneWidget);
      await tester.tap(find.text('Materials'));
      await tester.pumpAndSettle();
      expect(find.text('Plywood'), findsOneWidget);
      await tester.tap(find.textContaining('Warnings ('));
      await tester.pumpAndSettle();
      expect(find.textContaining('minOuterSection'), findsWidgets);
    });

    testWidgets('warning tab shows the count', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ResultsTabs(plan: planFor())),
        ),
      );
      expect(find.text('Warnings (0)'), findsOneWidget);
    });
  });
}
