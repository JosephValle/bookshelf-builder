import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/inputs_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  late Inputs current;
  var resets = 0;

  Future<void> pump(
    WidgetTester tester, {
    Inputs start = const Inputs(),
  }) async {
    current = start;
    resets = 0;
    tester.view.physicalSize = const Size(600, 3000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: InputsPanel(
                inputs: current,
                plan: planFor(current),
                onChanged: (i) => setState(() => current = i),
                onReset: () => resets++,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('InputsPanel', () {
    testWidgets('editing the window width updates inputs', (tester) async {
      await pump(tester);
      await tester.enterText(find.widgetWithText(TextField, 'Width'), '50');
      expect(current.windowW, 50);
    });

    testWidgets('each dimension field is wired to its input', (tester) async {
      await pump(tester);
      final fields = {
        'Height': (Inputs i) => i.windowH,
        'Left column': (Inputs i) => i.left,
        'Right column': (Inputs i) => i.right,
        'Top bar': (Inputs i) => i.top,
        'Bottom bar': (Inputs i) => i.bottom,
        'Total depth': (Inputs i) => i.depth,
        'Target height': (Inputs i) => i.targetClearH,
        'Max shelf width': (Inputs i) => i.maxShelfWidth,
        'Toe kick': (Inputs i) => i.toeKick,
      };
      for (final e in fields.entries) {
        await tester.enterText(find.widgetWithText(TextField, e.key), '17');
        expect(e.value(current), 17, reason: e.key);
      }
    });

    testWidgets('depth presets set the depth', (tester) async {
      await pump(tester);
      await tester.tap(find.text('1x8 7 1/4"'));
      expect(current.depth, 7.25);
      await tester.tap(find.text('1x10 9 1/4"'));
      expect(current.depth, 9.25);
      await tester.tap(find.text('1x12 11 1/4"'));
      expect(current.depth, 11.25);
    });

    testWidgets('shelf presets set the target height', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Paperback 8"'));
      expect(current.targetClearH, 8);
    });

    testWidgets('toe kick field disappears when off the floor', (tester) async {
      await pump(tester);
      expect(find.widgetWithText(TextField, 'Toe kick'), findsOneWidget);
      await tester.tap(find.text('On the floor (toe kick)'));
      await tester.pump();
      expect(current.onFloor, isFalse);
      expect(find.widgetWithText(TextField, 'Toe kick'), findsNothing);
    });

    testWidgets('edge band switch toggles the stiffener', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Front edge band (36 in shelf span)'));
      expect(current.edgeStiffener, isTrue);
    });

    testWidgets('wall fields are visible without expanding anything', (
      tester,
    ) async {
      await pump(tester);
      expect(find.text('Wall (optional)'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Wall width'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Wall height'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextField, 'Wall width'),
        '120',
      );
      expect(current.wallW, 120);
    });

    testWidgets('column fields are editable without a wall', (tester) async {
      await pump(tester);
      final field = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Left column'),
      );
      expect(field.enabled, isTrue);
      expect(
        find.textContaining('Sizes come from the wall'),
        findsNothing,
      );
    });

    testWidgets(
      'a wall width locks the columns and shows the resolved widths',
      (tester) async {
        await pump(tester, start: const Inputs(wallW: 120));
        final left = tester.widget<TextField>(
          find.widgetWithText(TextField, 'Left column'),
        );
        expect(left.enabled, isFalse);
        expect(left.controller!.text, '36');
        expect(
          find.textContaining('Sizes come from the wall'),
          findsOneWidget,
        );
      },
    );

    testWidgets('turning fill off unlocks the columns', (tester) async {
      await pump(tester, start: const Inputs(wallW: 120, fillWall: false));
      final left = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Left column'),
      );
      expect(left.enabled, isTrue);
      expect(left.controller!.text, '14');
    });

    testWidgets('reset calls back', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Reset to defaults'));
      expect(resets, 1);
    });
  });
}
