import 'package:bookshelf_builder/features/planner/presentation/widgets/action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ActionBar', () {
    testWidgets('each button fires its callback', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionBar(
              onCopyCsv: () => calls.add('csv'),
              onCopySummary: () => calls.add('summary'),
              onExportPdf: () => calls.add('pdf'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Copy CSV'));
      await tester.tap(find.text('Copy summary'));
      await tester.tap(find.text('Export PDF'));
      expect(calls, ['csv', 'summary', 'pdf']);
    });
  });

  group('ActionBar save button', () {
    Future<void> pump(WidgetTester tester, {VoidCallback? onSavePdf}) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionBar(
                onCopyCsv: () {},
                onCopySummary: () {},
                onExportPdf: () {},
                onSavePdf: onSavePdf,
              ),
            ),
          ),
        );

    testWidgets('is hidden when the platform cannot save', (tester) async {
      await pump(tester);
      expect(find.text('Save PDF'), findsNothing);
    });

    testWidgets('fires its callback when shown', (tester) async {
      var saves = 0;
      await pump(tester, onSavePdf: () => saves++);
      await tester.tap(find.text('Save PDF'));
      expect(saves, 1);
    });
  });
}
