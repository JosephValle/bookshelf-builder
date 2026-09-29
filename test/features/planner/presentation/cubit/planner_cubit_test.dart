import 'package:bloc_test/bloc_test.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_clipboard_writer.dart';
import '../../support/fake_inputs_store.dart';
import '../../support/fake_pdf_exporter.dart';

void main() {
  late FakeClipboardWriter clipboard;
  late FakePdfExporter pdf;
  late FakeInputsStore store;

  PlannerCubit build() =>
      PlannerCubit(clipboard: clipboard, pdfExporter: pdf, store: store);

  setUp(() {
    clipboard = FakeClipboardWriter();
    pdf = FakePdfExporter();
    store = FakeInputsStore();
  });

  group('initial state', () {
    test('uses default inputs and their plan', () {
      final cubit = build();
      expect(cubit.state.inputs, const Inputs());
      expect(cubit.state.plan.ringW, 76);
      expect(cubit.state.notice, isNull);
    });

    test('can start from custom inputs', () {
      final cubit = PlannerCubit(
        clipboard: clipboard,
        pdfExporter: pdf,
        store: store,
        initial: const Inputs(windowW: 40),
      );
      expect(cubit.state.plan.ringW, 68);
    });
  });

  group('inputs', () {
    blocTest<PlannerCubit, PlannerState>(
      'setInputs recomputes the plan',
      build: build,
      act: (c) => c.setInputs(const Inputs(windowW: 40)),
      verify: (c) {
        expect(c.state.inputs.windowW, 40);
        expect(c.state.plan.ringW, 68);
      },
    );

    blocTest<PlannerCubit, PlannerState>(
      'setInputs with identical inputs does not emit',
      build: build,
      act: (c) => c.setInputs(const Inputs()),
      expect: () => <PlannerState>[],
    );

    blocTest<PlannerCubit, PlannerState>(
      'update applies a change to the current inputs',
      build: build,
      act: (c) => c.update((i) => i.copyWith(left: 20)),
      verify: (c) => expect(c.state.plan.ringW, 82),
    );

    blocTest<PlannerCubit, PlannerState>(
      'a bad input surfaces an error in the plan',
      build: build,
      act: (c) => c.update((i) => i.copyWith(windowW: 70)),
      verify: (c) => expect(c.state.plan.errors, isNotEmpty),
    );

    blocTest<PlannerCubit, PlannerState>(
      'reset restores the defaults',
      build: build,
      act: (c) {
        c.update((i) => i.copyWith(left: 20));
        c.reset();
      },
      verify: (c) => expect(c.state.inputs, const Inputs()),
    );
  });

  group('persistence', () {
    test('every input change is saved', () {
      final cubit = build();
      cubit.update((i) => i.copyWith(left: 20));
      cubit.update((i) => i.copyWith(right: 18));
      expect(store.saves.length, 2);
      expect(store.saved, cubit.state.inputs);
    });

    test('an unchanged input is not saved again', () {
      final cubit = build();
      cubit.setInputs(const Inputs());
      expect(store.saves, isEmpty);
    });

    test('actions do not touch the saved inputs', () async {
      final cubit = build();
      await cubit.copyCsv();
      expect(store.saves, isEmpty);
      expect(store.clears, 0);
    });

    test('reset clears the saved copy and restores every default', () {
      final cubit = build();
      cubit.update(
        (i) => i.copyWith(
          left: 20,
          maxShelfWidth: 16,
          wallW: () => 120,
          fillWall: false,
        ),
      );
      cubit.reset();
      expect(cubit.state.inputs, const Inputs());
      expect(store.clears, 1);
      expect(store.saved, isNull);
    });

    test('reset also works from the defaults', () {
      final cubit = build();
      cubit.reset();
      expect(cubit.state.inputs, const Inputs());
      expect(store.clears, 1);
    });

    test('resolved wall inputs drive the plan', () {
      final cubit = build();
      cubit.update((i) => i.copyWith(wallW: () => 120));
      expect(cubit.state.plan.ringW, 120);
      expect(cubit.state.inputs.left, 14);
      expect(cubit.state.plan.inputs.left, 36);
    });
  });

  group('actions', () {
    test('copyCsv writes the CSV and posts a notice', () async {
      final cubit = build();
      await cubit.copyCsv();
      expect(clipboard.writes.single, startsWith('Part,Qty,Length'));
      expect(cubit.state.notice, 'Cut list copied as CSV');
      expect(cubit.state.noticeId, 1);
    });

    test('copySummary writes the summary and posts a notice', () async {
      final cubit = build();
      await cubit.copySummary();
      expect(clipboard.writes.single, startsWith('Shelf Planner summary'));
      expect(cubit.state.notice, 'Summary copied');
    });

    test('exportPdf hands the current plan to the exporter', () async {
      final cubit = build();
      await cubit.exportPdf();
      expect(pdf.exported.single, cubit.state.plan);
      expect(cubit.state.notice, 'PDF ready');
    });

    test('clipboard failures become a notice, not a crash', () async {
      clipboard.fail = true;
      final cubit = build();
      await cubit.copyCsv();
      expect(cubit.state.notice, 'Could not copy the cut list');
      await cubit.copySummary();
      expect(cubit.state.notice, 'Could not copy the summary');
    });

    test('pdf failures become a notice, not a crash', () async {
      pdf.fail = true;
      final cubit = build();
      await cubit.exportPdf();
      expect(cubit.state.notice, 'Could not create the PDF');
    });

    test('repeating an action still produces a new notice id', () async {
      final cubit = build();
      await cubit.copyCsv();
      await cubit.copyCsv();
      expect(cubit.state.noticeId, 2);
    });

    test('an input change clears the notice', () async {
      final cubit = build();
      await cubit.copyCsv();
      cubit.update((i) => i.copyWith(left: 20));
      expect(cubit.state.notice, isNull);
    });
  });
}
