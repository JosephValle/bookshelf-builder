import 'package:bookshelf_builder/app/app.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/screens/planner_screen.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/results_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/planner/support/fake_clipboard_writer.dart';
import '../features/planner/support/fake_inputs_store.dart';
import '../features/planner/support/fake_pane_layout_store.dart';
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

    testWidgets('starts from the saved inputs and panes', (tester) async {
      tester.view.physicalSize = const Size(1600, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ShelfPlannerApp(
          clipboard: FakeClipboardWriter(),
          pdfExporter: FakePdfExporter(),
          store: FakeInputsStore(),
          paneStore: FakePaneLayoutStore(),
          initial: const Inputs(windowW: 40),
          initialPanes: const PaneWidths(inputs: 400, results: 450),
        ),
      );
      final cubit = tester
          .element(find.byType(PlannerScreen))
          .read<PlannerCubit>();
      expect(cubit.state.plan.ringW, 68);
      expect(tester.getSize(find.byType(ResultsTabs)).width, 450);
    });

    testWidgets('a change in the app is saved and survives a rebuild', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final store = FakeInputsStore();
      await tester.pumpWidget(
        ShelfPlannerApp(
          clipboard: FakeClipboardWriter(),
          pdfExporter: FakePdfExporter(),
          store: store,
          paneStore: FakePaneLayoutStore(),
        ),
      );
      await tester.enterText(find.widgetWithText(TextField, 'Width'), '44');
      await tester.pump();
      expect(store.saved!.windowW, 44);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(
        ShelfPlannerApp(
          clipboard: FakeClipboardWriter(),
          pdfExporter: FakePdfExporter(),
          store: store,
          paneStore: FakePaneLayoutStore(),
          initial: store.saved!,
        ),
      );
      final cubit = tester
          .element(find.byType(PlannerScreen))
          .read<PlannerCubit>();
      expect(cubit.state.inputs.windowW, 44);
    });
  });
}
