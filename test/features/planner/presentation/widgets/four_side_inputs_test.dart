import 'package:bookshelf_builder/features/planner/domain/models/sides.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/four_side_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Sides current;

  Future<void> pump(WidgetTester tester, {Sides start = const Sides()}) async {
    current = start;
    tester.view.physicalSize = const Size(700, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: FourSideInputs(
                name: 'trim',
                sides: current,
                min: 0,
                max: 8,
                onChanged: (s) => setState(() => current = s),
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('FourSideInputs', () {
    testWidgets('starts with a horizontal and a vertical field', (
      tester,
    ) async {
      await pump(tester);
      expect(find.widgetWithText(TextField, 'Horizontal trim'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Vertical trim'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Top trim'), findsNothing);
    });

    testWidgets('horizontal sets top and bottom together', (tester) async {
      await pump(tester);
      await tester.enterText(
        find.widgetWithText(TextField, 'Horizontal trim'),
        '3',
      );
      expect(current, const Sides(top: 3, bottom: 3));
    });

    testWidgets('vertical sets left and right together', (tester) async {
      await pump(tester);
      await tester.enterText(
        find.widgetWithText(TextField, 'Vertical trim'),
        '2',
      );
      expect(current, const Sides(left: 2, right: 2));
    });

    testWidgets('zero is accepted', (tester) async {
      await pump(tester, start: const Sides(top: 3, bottom: 3));
      await tester.enterText(
        find.widgetWithText(TextField, 'Horizontal trim'),
        '0',
      );
      expect(current, const Sides());
    });

    testWidgets('the switch reveals four separate fields', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Set all four sides separately'));
      await tester.pump();
      for (final l in ['Top trim', 'Bottom trim', 'Left trim', 'Right trim']) {
        expect(find.widgetWithText(TextField, l), findsOneWidget, reason: l);
      }
      expect(find.widgetWithText(TextField, 'Horizontal trim'), findsNothing);
    });

    testWidgets('each separate field sets only its own side', (tester) async {
      await pump(
        tester,
        start: const Sides(top: 1, left: 1, right: 1, bottom: 1),
      );
      await tester.tap(find.text('Set all four sides separately'));
      await tester.pump();
      await tester.enterText(find.widgetWithText(TextField, 'Top trim'), '4');
      expect(current.top, 4);
      expect(current.bottom, 1);
      await tester.enterText(find.widgetWithText(TextField, 'Right trim'), '5');
      expect(current.right, 5);
      expect(current.left, 1);
    });

    testWidgets('unequal sides open in separate mode', (tester) async {
      await pump(tester, start: const Sides(top: 3, bottom: 1));
      expect(find.widgetWithText(TextField, 'Top trim'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Horizontal trim'), findsNothing);
    });

    testWidgets('turning separate mode off pairs the sides again', (
      tester,
    ) async {
      await pump(
        tester,
        start: const Sides(top: 3, bottom: 1, left: 2, right: 5),
      );
      await tester.tap(find.text('Set all four sides separately'));
      await tester.pump();
      expect(current, const Sides(top: 3, bottom: 3, left: 2, right: 2));
      expect(find.widgetWithText(TextField, 'Horizontal trim'), findsOneWidget);
    });

    testWidgets('labels have no suffix without a name', (tester) async {
      tester.view.physicalSize = const Size(700, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: FourSideInputs(
                sides: const Sides(),
                min: 0,
                max: 8,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );
      expect(find.widgetWithText(TextField, 'Horizontal'), findsOneWidget);
    });
  });
}
