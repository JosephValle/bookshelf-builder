import 'package:bookshelf_builder/features/planner/presentation/widgets/key_value_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget row, {double width = 400}) {
    tester.view.physicalSize = Size(width, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    return tester.pumpWidget(MaterialApp(home: Scaffold(body: row)));
  }

  group('KeyValueRow', () {
    testWidgets('shows the label and value', (tester) async {
      await pump(tester, const KeyValueRow(label: 'Total', value: r'$10.00'));
      expect(find.text('Total'), findsOneWidget);
      expect(find.text(r'$10.00'), findsOneWidget);
    });

    testWidgets('the value sits to the right of the label', (tester) async {
      await pump(tester, const KeyValueRow(label: 'Total', value: r'$10.00'));
      expect(
        tester.getTopLeft(find.text(r'$10.00')).dx,
        greaterThan(tester.getTopLeft(find.text('Total')).dx),
      );
      expect(
        tester.getTopRight(find.text(r'$10.00')).dx,
        closeTo(400 - 0, 400),
      );
    });

    testWidgets('shows a caption under the label when given', (tester) async {
      await pump(
        tester,
        const KeyValueRow(label: 'Plywood', value: '3', caption: 'per sheet'),
      );
      expect(find.text('per sheet'), findsOneWidget);
      expect(
        tester.getTopLeft(find.text('per sheet')).dy,
        greaterThan(tester.getTopLeft(find.text('Plywood')).dy),
      );
    });

    testWidgets('has no caption by default', (tester) async {
      await pump(tester, const KeyValueRow(label: 'A', value: 'B'));
      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets('emphasis makes the label larger and bold', (tester) async {
      await pump(
        tester,
        const Column(
          children: [
            KeyValueRow(label: 'Plain', value: '1'),
            KeyValueRow(label: 'Strong', value: '2', emphasis: true),
          ],
        ),
      );
      final plain = tester.widget<Text>(find.text('Plain'));
      final strong = tester.widget<Text>(find.text('Strong'));
      expect(strong.style!.fontWeight, FontWeight.w600);
      expect(strong.style!.fontSize!, greaterThan(plain.style!.fontSize!));
    });

    testWidgets('a long label wraps instead of overflowing', (tester) async {
      await pump(
        tester,
        const KeyValueRow(
          label:
              'A very long label that should wrap onto more than one line '
              'when the row is narrow',
          value: r'$1,234.56',
        ),
        width: 240,
      );
      expect(tester.takeException(), isNull);
    });
  });
}
