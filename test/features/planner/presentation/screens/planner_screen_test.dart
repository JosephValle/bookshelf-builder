import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/pane_layout_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/screens/planner_screen.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_view.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/pane_divider.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/results_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_clipboard_writer.dart';
import '../../support/fake_inputs_store.dart';
import '../../support/fake_pane_layout_store.dart';
import '../../support/fake_pdf_exporter.dart';

Future<void> type2(WidgetTester tester, String label, String text) async {
  await tester.enterText(find.widgetWithText(TextField, label), text);
  await tester.pump();
}

void main() {
  late FakeClipboardWriter clipboard;
  late FakePdfExporter pdf;
  late PlannerCubit cubit;
  late FakeInputsStore store;
  late FakePaneLayoutStore paneStore;
  late PaneLayoutCubit panes;

  Future<void> pump(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    clipboard = FakeClipboardWriter();
    pdf = FakePdfExporter();
    store = FakeInputsStore();
    paneStore = FakePaneLayoutStore();
    cubit = PlannerCubit(clipboard: clipboard, pdfExporter: pdf, store: store);
    panes = PaneLayoutCubit(store: paneStore);
    addTearDown(cubit.close);
    addTearDown(panes.close);
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: cubit),
            BlocProvider.value(value: panes),
          ],
          child: const PlannerScreen(),
        ),
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
      expect(clipboard.writes.single, startsWith('Piece,Part,Qty'));
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
      expect(cubit.state.inputs, Inputs.home);
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

  group('wall margins and window gaps through the real fields', () {
    Future<void> type(WidgetTester tester, String label, String text) async {
      final f = find.widgetWithText(TextField, label);
      expect(f, findsOneWidget, reason: label);
      await tester.ensureVisible(f);
      await tester.enterText(f, text);
      await tester.pump();
    }

    testWidgets('a wall width grows the ring to fill it', (tester) async {
      await pump(tester, const Size(1400, 900));
      await type(tester, 'Wall width', '120');
      expect(cubit.state.plan.ringW, 120);
    });

    testWidgets('side and top margins shrink the ring', (tester) async {
      await pump(tester, const Size(1400, 900));
      await type(tester, 'Wall width', '120');
      await type(tester, 'Wall height', '96');
      await type(tester, 'Left margin', '10');
      await type(tester, 'Right margin', '14');
      await type(tester, 'Top margin', '8');
      expect(cubit.state.inputs.wallMarginLeft, 10);
      expect(cubit.state.inputs.wallMarginRight, 14);
      expect(cubit.state.inputs.wallMarginTop, 8);
      expect(cubit.state.plan.ringW, 96);
      expect(cubit.state.plan.ringH, 88);
      expect(cubit.state.plan.ringOffsetOnWall, 10);
    });

    testWidgets('margins are saved', (tester) async {
      await pump(tester, const Size(1400, 900));
      await type(tester, 'Wall width', '120');
      await type(tester, 'Left margin', '10');
      expect(store.saved!.wallMarginLeft, 10);
    });

    testWidgets('gaps grow the opening', (tester) async {
      await pump(tester, const Size(1400, 900));
      final tile = find.byKey(const ValueKey('gap-tile'));
      await tester.ensureVisible(tile);
      await tester.tap(tile);
      await tester.pumpAndSettle();
      await type(tester, 'Horizontal gap', '3');
      await type(tester, 'Vertical gap', '2');
      expect(cubit.state.inputs.gap.top, 3);
      expect(cubit.state.inputs.gap.bottom, 3);
      expect(cubit.state.inputs.gap.left, 2);
      expect(cubit.state.inputs.gap.right, 2);
      expect(cubit.state.plan.ringW, 76 + 4);
      expect(cubit.state.plan.ringH, 76 + 6);
    });

    testWidgets('trim grows the opening too', (tester) async {
      await pump(tester, const Size(1400, 900));
      final tile = find.byKey(const ValueKey('trim-tile'));
      await tester.ensureVisible(tile);
      await tester.tap(tile);
      await tester.pumpAndSettle();
      await type(tester, 'Horizontal trim', '2');
      await type(tester, 'Vertical trim', '4');
      expect(cubit.state.inputs.trim.top, 2);
      expect(cubit.state.inputs.trim.left, 4);
      expect(cubit.state.plan.ringW, 76 + 8);
      expect(cubit.state.plan.ringH, 76 + 4);
    });

    testWidgets('the drawing repaints when a margin changes', (tester) async {
      await pump(tester, const Size(1400, 900));
      await type(tester, 'Wall width', '120');
      final before = tester.widget<CustomPaint>(
        find
            .descendant(
              of: find.byType(ElevationView),
              matching: find.byType(CustomPaint),
            )
            .first,
      );
      await type(tester, 'Left margin', '10');
      final after = tester.widget<CustomPaint>(
        find
            .descendant(
              of: find.byType(ElevationView),
              matching: find.byType(CustomPaint),
            )
            .first,
      );
      expect(after.painter!.shouldRepaint(before.painter!), isTrue);
    });
  });

  group('resizable panes', () {
    double width(WidgetTester tester, Finder f) => tester.getSize(f).width;

    testWidgets('starts with the default widths', (tester) async {
      await pump(tester, const Size(1400, 900));
      expect(width(tester, find.byType(ResultsTabs)), 360);
      expect(find.byType(PaneDivider), findsNWidgets(2));
    });

    testWidgets('dragging the first divider widens the inputs pane', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      await tester.drag(find.byType(PaneDivider).first, const Offset(80, 0));
      await tester.pump();
      expect(panes.state.inputs, greaterThan(320));
      expect(panes.state.results, 360);
    });

    testWidgets('dragging the second divider left widens the results pane', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      await tester.drag(find.byType(PaneDivider).last, const Offset(-80, 0));
      await tester.pump();
      expect(width(tester, find.byType(ResultsTabs)), greaterThan(360));
    });

    testWidgets('the drawing keeps its minimum width however far you drag', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      await tester.drag(find.byType(PaneDivider).first, const Offset(1200, 0));
      await tester.pump();
      expect(
        width(tester, find.byType(ElevationView)),
        greaterThanOrEqualTo(PaneLimits.minDrawing),
      );
    });

    testWidgets('side panes keep their minimum widths', (tester) async {
      await pump(tester, const Size(1400, 900));
      await tester.drag(find.byType(PaneDivider).first, const Offset(-600, 0));
      await tester.drag(find.byType(PaneDivider).last, const Offset(600, 0));
      await tester.pump();
      expect(panes.state.inputs, PaneLimits.minInputs);
      expect(panes.state.results, PaneLimits.minResults);
    });

    testWidgets('the widths are saved when the drag ends', (tester) async {
      await pump(tester, const Size(1400, 900));
      await tester.drag(find.byType(PaneDivider).first, const Offset(60, 0));
      await tester.pump();
      expect(paneStore.saved, panes.state);
    });

    testWidgets('the layout adapts when the window shrinks', (tester) async {
      await pump(tester, const Size(1800, 900));
      await tester.drag(find.byType(PaneDivider).first, const Offset(200, 0));
      await tester.drag(find.byType(PaneDivider).last, const Offset(-200, 0));
      await tester.pump();
      tester.view.physicalSize = const Size(1100, 900);
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(
        width(tester, find.byType(ElevationView)),
        greaterThanOrEqualTo(PaneLimits.minDrawing),
      );
    });

    testWidgets('a saved layout is used at startup', (tester) async {
      tester.view.physicalSize = const Size(1600, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final c = PlannerCubit(
        clipboard: FakeClipboardWriter(),
        pdfExporter: FakePdfExporter(),
        store: FakeInputsStore(),
      );
      final p = PaneLayoutCubit(
        store: FakePaneLayoutStore(),
        initial: const PaneWidths(inputs: 400, results: 450),
      );
      addTearDown(c.close);
      addTearDown(p.close);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: c),
              BlocProvider.value(value: p),
            ],
            child: const PlannerScreen(),
          ),
        ),
      );
      expect(width(tester, find.byType(ResultsTabs)), 450);
    });

    testWidgets('reset restores the pane widths and the inputs', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      await tester.drag(find.byType(PaneDivider).first, const Offset(80, 0));
      await type2(tester, 'Width', '40');
      await tester.ensureVisible(find.text('Reset to defaults'));
      await tester.tap(find.text('Reset to defaults'));
      await tester.pump();
      expect(panes.state, const PaneWidths());
      expect(paneStore.clears, 1);
      expect(cubit.state.inputs, Inputs.home);
      expect(store.clears, 1);
    });

    testWidgets('the narrow layout has no dividers', (tester) async {
      await pump(tester, const Size(500, 900));
      expect(find.byType(PaneDivider), findsNothing);
    });
  });

  group('saving the PDF', () {
    testWidgets('shows a Save PDF button where the platform can save', (
      tester,
    ) async {
      await pump(tester, const Size(1400, 900));
      expect(find.text('Save PDF'), findsOneWidget);
    });

    testWidgets('hides the button where it cannot', (tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final fake = FakePdfExporter()..saveSupported = false;
      final c = PlannerCubit(
        clipboard: FakeClipboardWriter(),
        pdfExporter: fake,
        store: FakeInputsStore(),
      );
      final p = PaneLayoutCubit(store: FakePaneLayoutStore());
      addTearDown(c.close);
      addTearDown(p.close);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: c),
              BlocProvider.value(value: p),
            ],
            child: const PlannerScreen(),
          ),
        ),
      );
      expect(find.text('Save PDF'), findsNothing);
      expect(find.text('Export PDF'), findsOneWidget);
    });

    testWidgets('saving offers to show the file in Finder', (tester) async {
      await pump(tester, const Size(1400, 900));
      await tester.tap(find.text('Save PDF'));
      await tester.pump();
      await tester.pump();
      expect(pdf.saved.length, 1);
      expect(find.text('PDF saved'), findsOneWidget);
      // Let the snack bar finish sliding in before tapping its action.
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Show in Finder'), findsOneWidget);
      await tester.tap(find.text('Show in Finder'));
      await tester.pump();
      expect(pdf.revealed, ['/tmp/shelf_planner.pdf']);
    });

    testWidgets('cancelling the save panel shows no message', (tester) async {
      await pump(tester, const Size(1400, 900));
      pdf.savePath = null;
      await tester.tap(find.text('Save PDF'));
      await tester.pump();
      await tester.pump();
      expect(find.text('PDF saved'), findsNothing);
      expect(find.text('Show in Finder'), findsNothing);
    });

    testWidgets('other messages have no Finder button', (tester) async {
      await pump(tester, const Size(1400, 900));
      await tester.tap(find.text('Copy CSV'));
      await tester.pump();
      await tester.pump();
      expect(find.text('Show in Finder'), findsNothing);
    });
  });
}

extension on Matcher {
  Matcher or(Matcher other) => anyOf(this, other);
}
