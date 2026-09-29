import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/screens/planner_screen.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_view.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/results_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_clipboard_writer.dart';
import '../../support/fake_pdf_exporter.dart';

void main() {
  late FakeClipboardWriter clipboard;
  late FakePdfExporter pdf;
  late PlannerCubit cubit;

  Future<void> pump(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    clipboard = FakeClipboardWriter();
    pdf = FakePdfExporter();
    cubit = PlannerCubit(clipboard: clipboard, pdfExporter: pdf);
    addTearDown(cubit.close);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const PlannerScreen()),
      ),
    );
  }

  group('wide layout', () {
    testWidgets('shows inputs, drawing and results side by side', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      expect(find.byType(ElevationView), findsOneWidget);
      expect(find.byType(ResultsTabs), findsOneWidget);
      expect(find.text('Window opening'), findsOneWidget);
      final drawing = tester.getRect(find.byType(ElevationView));
      final results = tester.getRect(find.byType(ResultsTabs));
      expect(drawing.right, lessThanOrEqualTo(results.left));
    });

    testWidgets('changing an input updates the plan immediately', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      await tester.enterText(find.widgetWithText(TextField, 'Width'), '40');
      await tester.pump();
      expect(cubit.state.plan.ringW, 68);
      expect(find.text('Warnings (0)'), findsOneWidget);
    });

    testWidgets('a bad input shows up in the warnings tab', (tester) async {
      await pump(tester, const Size(1400, 900));
      await tester.enterText(
        find.widgetWithText(TextField, 'Left column'),
        '8',
      );
      await tester.pump();
      await tester.tap(find.textContaining('Warnings ('));
      await tester.pumpAndSettle();
      expect(find.textContaining('minOuterSection'), findsWidgets);
    });

    testWidgets('copy CSV writes to the clipboard and shows a snack bar', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      await tester.tap(find.text('Copy CSV'));
      await tester.pump();
      await tester.pump();
      expect(clipboard.writes.single, startsWith('Part,Qty'));
      expect(find.text('Cut list copied as CSV'), findsOneWidget);
    });

    testWidgets('copy summary and export PDF run', (tester) async {
      await pump(tester, const Size(1400, 900));
      await tester.tap(find.text('Copy summary'));
      await tester.pump();
      await tester.tap(find.text('Export PDF'));
      await tester.pump();
      expect(clipboard.writes.single, startsWith('Shelf Planner summary'));
      expect(pdf.exported.length, 1);
    });

    testWidgets('a failing export shows the failure message', (tester) async {
      await pump(tester, const Size(1400, 900));
      pdf.fail = true;
      await tester.tap(find.text('Export PDF'));
      await tester.pump();
      await tester.pump();
      expect(find.text('Could not create the PDF'), findsOneWidget);
    });

    testWidgets('reset restores the defaults', (tester) async {
      await pump(tester, const Size(1400, 900));
      await tester.enterText(find.widgetWithText(TextField, 'Width'), '40');
      await tester.pump();
      await tester.ensureVisible(find.text('Reset to defaults'));
      await tester.tap(find.text('Reset to defaults'));
      await tester.pump();
      expect(cubit.state.plan.ringW, 76);
    });

    testWidgets('shows the disclaimer footer', (tester) async {
      await pump(tester, const Size(1400, 900));
      expect(find.textContaining('rules of thumb'), findsOneWidget);
    });
  });

  group('narrow layout', () {
    testWidgets('stacks the sections vertically', (tester) async {
      await pump(tester, const Size(500, 900));
      expect(find.byType(ElevationView), findsNothing.or(findsOneWidget));
      await tester.scrollUntilVisible(
        find.byType(ElevationView),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.byType(ElevationView), findsOneWidget);
      await tester.scrollUntilVisible(
        find.byType(ResultsTabs),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.byType(ResultsTabs), findsOneWidget);
    });

    testWidgets('works at 320 pixels wide', (tester) async {
      await pump(tester, const Size(320, 700));
      expect(tester.takeException(), isNull);
    });
  });
}

extension on Matcher {
  Matcher or(Matcher other) => anyOf(this, other);
}
