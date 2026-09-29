import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/materials_view.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  Future<void> pump(WidgetTester tester, Inputs i) {
    tester.view.physicalSize = const Size(800, 5000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: MaterialsView(plan: planFor(i))),
      ),
    );
  }

  group('MaterialsView', () {
    testWidgets('groups everything into titled cards', (tester) async {
      await pump(tester, const Inputs());
      for (final title in [
        'Plywood',
        'Estimated cost',
        'Tools and supplies',
        'Recommended tools',
        'Buying',
        'Wall attachment',
      ]) {
        expect(find.text(title), findsOneWidget, reason: title);
      }
      expect(find.byType(SectionCard), findsNWidgets(6));
    });

    testWidgets('shows plywood as label and value rows', (tester) async {
      await pump(tester, const Inputs());
      final p = planFor();
      expect(find.text('3/4" plywood'), findsOneWidget);
      expect(find.text('1/4" plywood'), findsOneWidget);
      expect(
        find.text(
          '${p.sheets.sheets34} sheet${p.sheets.sheets34 == 1 ? '' : 's'}',
        ),
        findsOneWidget,
      );
      expect(find.textContaining('per 4x8 sheet'), findsOneWidget);
      expect(find.text('Back panels, approximate'), findsOneWidget);
    });

    testWidgets('a single sheet is not pluralized', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text('1 sheet'), findsOneWidget);
      expect(find.text('1 sheets'), findsNothing);
    });

    testWidgets('shows both notes', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text(PlannerNotes.store), findsOneWidget);
      expect(find.text(PlannerNotes.wall), findsOneWidget);
    });

    testWidgets('shows edge band length only when enabled', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text('Front edge band'), findsNothing);
      await pump(tester, const Inputs(edgeStiffener: true));
      expect(find.text('Front edge band'), findsOneWidget);
      expect(find.textContaining('linear feet'), findsOneWidget);
    });

    testWidgets('includes the cost estimate and the tools', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text("Lowe's estimate"), findsOneWidget);
      expect(find.text('Estimated total'), findsOneWidget);
      expect(find.text('Stud finder'), findsWidgets);
    });

    testWidgets('scrolls on a small screen', (tester) async {
      tester.view.physicalSize = const Size(400, 500);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MaterialsView(plan: planFor())),
        ),
      );
      await tester.scrollUntilVisible(
        find.text('Wall attachment'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Wall attachment'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
