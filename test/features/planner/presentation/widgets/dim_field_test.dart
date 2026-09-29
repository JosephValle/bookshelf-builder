import 'package:bookshelf_builder/features/planner/presentation/widgets/dim_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('DimField', () {
    testWidgets('shows the value as a fraction', (tester) async {
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Width',
            value: 11.25,
            min: 1,
            max: 20,
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.widgetWithText(TextField, '11 1/4'), findsOneWidget);
    });

    testWidgets('typing a fraction reports inches', (tester) async {
      double? got;
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Width',
            value: 10,
            min: 1,
            max: 20,
            onChanged: (v) => got = v,
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), '11 1/4');
      expect(got, 11.25);
    });

    testWidgets('typing a decimal reports inches', (tester) async {
      double? got;
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Width',
            value: 10,
            min: 1,
            max: 20,
            onChanged: (v) => got = v,
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), '12.5');
      expect(got, 12.5);
    });

    testWidgets('invalid text is ignored', (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Width',
            value: 10,
            min: 1,
            max: 20,
            onChanged: (_) => calls++,
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'abc');
      await tester.enterText(find.byType(TextField), '0');
      expect(calls, 0);
    });

    testWidgets('an optional field reports null when cleared', (tester) async {
      var got = 5.0 as double?;
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Wall',
            value: 5,
            slider: false,
            onCleared: () => got = null,
            onChanged: (v) => got = v,
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), '');
      expect(got, isNull);
    });

    testWidgets('dragging the slider reports a sixteenth-rounded value', (
      tester,
    ) async {
      double? got;
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Width',
            value: 10,
            min: 0,
            max: 20,
            onChanged: (v) => got = v,
          ),
        ),
      );
      final r = tester.getRect(find.byType(Slider));
      await tester.tapAt(Offset(r.left + r.width * 0.9, r.center.dy));
      expect(got, isNotNull);
      expect((got! * 16) % 1, 0);
    });

    testWidgets('slider is hidden when disabled', (tester) async {
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Wall',
            value: null,
            slider: false,
            onCleared: () {},
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.byType(Slider), findsNothing);
    });

    testWidgets('an external value change updates the text', (tester) async {
      Widget build(double v) => host(
        DimField(label: 'Width', value: v, min: 1, max: 30, onChanged: (_) {}),
      );
      await tester.pumpWidget(build(10));
      await tester.pumpWidget(build(14.5));
      expect(find.widgetWithText(TextField, '14 1/2'), findsOneWidget);
    });

    testWidgets('a value outside the range still renders the slider', (
      tester,
    ) async {
      await tester.pumpWidget(
        host(
          DimField(
            label: 'Width',
            value: 500,
            min: 1,
            max: 30,
            onChanged: (_) {},
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.byType(Slider), findsOneWidget);
    });
  });
}
