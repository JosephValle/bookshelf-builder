import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/wall_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  late Inputs current;

  Future<void> pump(
    WidgetTester tester, {
    Inputs start = const Inputs(),
  }) async {
    current = start;
    tester.view.physicalSize = const Size(600, 3000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: WallInputs(
                inputs: current,
                plan: planFor(current),
                onChanged: (i) => setState(() => current = i),
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('wall size', () {
    testWidgets('editing and clearing the wall size update the inputs', (
      tester,
    ) async {
      await pump(tester);
      await tester.enterText(
        find.widgetWithText(TextField, 'Wall width'),
        '120',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Wall height'),
        '96',
      );
      expect(current.wallW, 120);
      expect(current.wallH, 96);
      await tester.enterText(find.widgetWithText(TextField, 'Wall width'), '');
      expect(current.wallW, isNull);
    });

    testWidgets('nothing else shows before a wall size is entered', (
      tester,
    ) async {
      await pump(tester);
      expect(find.text('Fill the wall up to the margins'), findsNothing);
      expect(find.text('Center window on wall'), findsNothing);
      expect(find.text('Keep clear of'), findsNothing);
    });
  });

  group('wall width', () {
    testWidgets('fill, margins and position appear with a wall width', (
      tester,
    ) async {
      await pump(tester);
      await tester.enterText(
        find.widgetWithText(TextField, 'Wall width'),
        '120',
      );
      await tester.pump();
      expect(find.text('Fill the wall up to the margins'), findsOneWidget);
      expect(find.text('Center window on wall'), findsOneWidget);
      expect(find.text('Keep clear of'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Left margin'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Right margin'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Top margin'), findsNothing);
      expect(
        find.widgetWithText(TextField, 'Window from wall left'),
        findsOneWidget,
      );
      expect(find.widgetWithText(TextField, 'Window from floor'), findsNothing);
    });

    testWidgets('shows the resulting column widths', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120));
      expect(find.text('Left column 36", right column 36"'), findsOneWidget);
    });

    testWidgets('typing a window position moves the window', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120));
      await tester.enterText(
        find.widgetWithText(TextField, 'Window from wall left'),
        '10',
      );
      await tester.pump();
      expect(current.windowFromWallLeft, 10);
      expect(find.text('Left column 10", right column 62"'), findsOneWidget);
    });

    testWidgets('a window position of zero is accepted', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120));
      await tester.enterText(
        find.widgetWithText(TextField, 'Window from wall left'),
        '0',
      );
      expect(current.windowFromWallLeft, 0);
    });

    testWidgets('the slider moves the window', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120));
      final r = tester.getRect(find.byType(Slider).last);
      await tester.tapAt(Offset(r.left + r.width * 0.9, r.center.dy));
      await tester.pump();
      expect(current.windowFromWallLeft, greaterThan(36));
    });

    testWidgets('the fill switch toggles fillWall', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120));
      await tester.tap(find.text('Fill the wall up to the margins'));
      await tester.pump();
      expect(current.fillWall, isFalse);
    });

    testWidgets('side margins change the column widths', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120));
      await tester.enterText(
        find.widgetWithText(TextField, 'Left margin'),
        '6',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Right margin'),
        '10',
      );
      await tester.pump();
      expect(current.wallMarginLeft, 6);
      expect(current.wallMarginRight, 10);
      expect(find.text('Left column 32", right column 34"'), findsOneWidget);
    });

    testWidgets('a margin of zero is accepted', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120, wallMarginLeft: 6));
      await tester.enterText(
        find.widgetWithText(TextField, 'Left margin'),
        '0',
      );
      expect(current.wallMarginLeft, 0);
    });
  });

  group('wall height', () {
    testWidgets('vertical controls appear with a wall height', (tester) async {
      await pump(tester, start: const Inputs(wallH: 96));
      expect(find.widgetWithText(TextField, 'Window from floor'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Top margin'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Left margin'), findsNothing);
      expect(
        find.widgetWithText(TextField, 'Window from wall left'),
        findsNothing,
      );
      expect(find.text('Fill the wall up to the margins'), findsOneWidget);
    });

    testWidgets('shows the resulting bar heights', (tester) async {
      await pump(tester, start: const Inputs(wallH: 96));
      expect(find.text('Top bar 24", bottom bar 24"'), findsOneWidget);
    });

    testWidgets('typing a floor distance moves the window up or down', (
      tester,
    ) async {
      await pump(tester, start: const Inputs(wallH: 96));
      await tester.enterText(
        find.widgetWithText(TextField, 'Window from floor'),
        '10',
      );
      await tester.pump();
      expect(current.windowFromFloor, 10);
      expect(find.text('Top bar 38", bottom bar 10"'), findsOneWidget);
    });

    testWidgets('a top margin shortens the top bar', (tester) async {
      await pump(tester, start: const Inputs(wallH: 96));
      await tester.enterText(
        find.widgetWithText(TextField, 'Top margin'),
        '12',
      );
      await tester.pump();
      expect(current.wallMarginTop, 12);
      expect(find.text('Top bar 18", bottom bar 18"'), findsOneWidget);
    });

    testWidgets('both axes show both summaries', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120, wallH: 96));
      expect(find.textContaining('Left column 36", right column 36"'),
          findsOneWidget);
      expect(find.textContaining('Top bar 24", bottom bar 24"'), findsOneWidget);
    });
  });

  group('center window', () {
    testWidgets('clears both positions', (tester) async {
      await pump(
        tester,
        start: const Inputs(
          wallW: 120,
          wallH: 96,
          windowFromWallLeft: 10,
          windowFromFloor: 5,
        ),
      );
      await tester.tap(find.text('Center window on wall'));
      await tester.pump();
      expect(current.windowFromWallLeft, isNull);
      expect(current.windowFromFloor, isNull);
    });
  });
}
