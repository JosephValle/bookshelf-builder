import 'package:bookshelf_builder/features/planner/presentation/widgets/pane_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<double> drags;
  late List<int> nudges;
  late int ends;

  Finder mouse() => find
      .descendant(
        of: find.byType(PaneDivider),
        matching: find.byType(MouseRegion),
      )
      .first;

  Future<void> pump(WidgetTester tester) async {
    drags = [];
    nudges = [];
    ends = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              PaneDivider(
                label: 'Resize test panel',
                onDrag: drags.add,
                onDragEnd: () => ends++,
                onNudge: nudges.add,
              ),
            ],
          ),
        ),
      ),
    );
  }

  group('PaneDivider', () {
    testWidgets('reports horizontal drags and the end of a drag', (
      tester,
    ) async {
      await pump(tester);
      await tester.drag(find.byType(PaneDivider), const Offset(40, 0));
      await tester.pump();
      expect(drags.fold<double>(0, (a, b) => a + b), greaterThan(0));
      expect(ends, 1);
    });

    testWidgets('reports left drags as negative', (tester) async {
      await pump(tester);
      await tester.drag(find.byType(PaneDivider), const Offset(-40, 0));
      expect(drags.fold<double>(0, (a, b) => a + b), lessThan(0));
    });

    testWidgets('ignores vertical drags', (tester) async {
      await pump(tester);
      await tester.drag(find.byType(PaneDivider), const Offset(0, 60));
      expect(drags.fold<double>(0, (a, b) => a + b), 0);
    });

    testWidgets('arrow keys nudge when focused', (tester) async {
      await pump(tester);
      final focus = Focus.of(tester.element(mouse()));
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      expect(nudges, [1, -1]);
    });

    testWidgets('is named for assistive technology', (tester) async {
      final handle = tester.ensureSemantics();
      await pump(tester);
      expect(find.bySemanticsLabel('Resize test panel'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('shows a resize cursor', (tester) async {
      await pump(tester);
      final region = tester.widget<MouseRegion>(mouse());
      expect(region.cursor, SystemMouseCursors.resizeColumn);
    });

    testWidgets('highlights when focused', (tester) async {
      await pump(tester);
      Container line() => tester.widget<Container>(
        find.descendant(
          of: find.byType(PaneDivider),
          matching: find.byType(Container),
        ),
      );
      final before = line().constraints!.maxWidth;
      Focus.of(tester.element(mouse())).requestFocus();
      await tester.pump();
      expect(line().constraints!.maxWidth, greaterThan(before));
    });
  });
}
