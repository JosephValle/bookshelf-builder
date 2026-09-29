import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/materials_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  Future<void> pump(WidgetTester tester, Inputs i) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: MaterialsView(plan: planFor(i))),
    ),
  );

  group('MaterialsView', () {
    testWidgets('shows sheet counts and both notes', (tester) async {
      await pump(tester, const Inputs());
      expect(find.textContaining('3/4" plywood:'), findsOneWidget);
      expect(find.textContaining('1/4" plywood: 1 sheets'), findsOneWidget);
      expect(find.text(PlannerNotes.store), findsOneWidget);
      expect(find.text(PlannerNotes.wall), findsOneWidget);
    });

    testWidgets('shows edge band length only when enabled', (tester) async {
      await pump(tester, const Inputs());
      expect(find.textContaining('Front edge band'), findsNothing);
      await pump(tester, const Inputs(edgeStiffener: true));
      expect(find.textContaining('linear feet'), findsOneWidget);
    });
  });
}
