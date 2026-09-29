import 'package:bookshelf_builder/app/app.dart';
import 'package:bookshelf_builder/features/planner/presentation/screens/planner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/planner/support/fake_clipboard_writer.dart';
import '../features/planner/support/fake_pdf_exporter.dart';

void main() {
  group('ShelfPlannerApp', () {
    testWidgets('launches the planner with injected services', (tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final clipboard = FakeClipboardWriter();
      await tester.pumpWidget(
        ShelfPlannerApp(clipboard: clipboard, pdfExporter: FakePdfExporter()),
      );
      expect(find.byType(PlannerScreen), findsOneWidget);
      await tester.tap(find.text('Copy summary'));
      await tester.pump();
      expect(clipboard.writes, hasLength(1));
    });

    testWidgets('supplies light and dark themes', (tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ShelfPlannerApp(
          clipboard: FakeClipboardWriter(),
          pdfExporter: FakePdfExporter(),
        ),
      );
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.theme!.brightness, Brightness.light);
      expect(app.darkTheme!.brightness, Brightness.dark);
    });
  });
}
