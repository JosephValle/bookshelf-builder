import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/tool_recommender.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/tools_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  Future<void> pump(WidgetTester tester, Inputs i) {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: ToolsView(plan: planFor(i))),
        ),
      ),
    );
  }

  group('ToolsView', () {
    testWidgets('has a heading and lists every recommendation', (tester) async {
      await pump(tester, const Inputs());
      expect(find.text('Recommended tools'), findsOneWidget);
      for (final t in const ToolRecommender().recommend(planFor())) {
        expect(find.text(t.name), findsOneWidget, reason: t.name);
        expect(find.text(t.reason), findsOneWidget, reason: t.reason);
      }
    });

    testWidgets('marks nice-to-have items with an Optional badge', (
      tester,
    ) async {
      await pump(tester, const Inputs());
      final optional = const ToolRecommender()
          .recommend(planFor())
          .where((t) => !t.essential)
          .length;
      expect(optional, greaterThan(0));
      expect(find.text('Optional'), findsNWidgets(optional));
      expect(find.text('Pocket hole jig'), findsOneWidget);
    });

    testWidgets('essential items get a check and optional items a plus', (
      tester,
    ) async {
      await pump(tester, const Inputs());
      final tools = const ToolRecommender().recommend(planFor());
      final essential = tools.where((t) => t.essential).length;
      expect(find.byIcon(Icons.check_circle_outline), findsNWidgets(essential));
      expect(
        find.byIcon(Icons.add_circle_outline),
        findsNWidgets(tools.length - essential),
      );
    });

    testWidgets('tool names are bold and reasons are muted', (tester) async {
      await pump(tester, const Inputs());
      final name = tester.widget<Text>(find.text('Stud finder'));
      expect(name.style!.fontWeight, FontWeight.w600);
      final reason = tester.widget<Text>(
        find.textContaining('Locates studs every'),
      );
      expect(reason.style!.color, isNotNull);
    });

    testWidgets('changes with the plan', (tester) async {
      await pump(tester, const Inputs());
      expect(find.textContaining('helper'), findsNothing);
      await pump(tester, const Inputs(windowH: 60));
      expect(find.textContaining('helper'), findsOneWidget);
    });
  });
}
