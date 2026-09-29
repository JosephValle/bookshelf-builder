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
    tester.view.physicalSize = const Size(600, 2000);
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

  group('WallInputs', () {
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

    testWidgets('fill and position controls appear only with a wall width', (
      tester,
    ) async {
      await pump(tester);
      expect(find.text('Columns fill the wall width'), findsNothing);
      expect(find.text('Center window on wall'), findsNothing);
      await tester.enterText(
        find.widgetWithText(TextField, 'Wall width'),
        '120',
      );
      await tester.pump();
      expect(find.text('Columns fill the wall width'), findsOneWidget);
      expect(find.text('Center window on wall'), findsOneWidget);
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

    testWidgets('center window clears the position', (tester) async {
      await pump(
        tester,
        start: const Inputs(wallW: 120, windowFromWallLeft: 10),
      );
      await tester.tap(find.text('Center window on wall'));
      await tester.pump();
      expect(current.windowFromWallLeft, isNull);
    });

    testWidgets('the fill switch toggles fillWall', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120));
      await tester.tap(find.text('Columns fill the wall width'));
      await tester.pump();
      expect(current.fillWall, isFalse);
    });
  });
}
