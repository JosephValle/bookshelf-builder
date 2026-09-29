import 'package:bloc_test/bloc_test.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/pane_layout_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_pane_layout_store.dart';

void main() {
  late FakePaneLayoutStore store;
  const total = 1600.0;
  const dividers = 24.0;

  PaneLayoutCubit build([PaneWidths initial = const PaneWidths()]) =>
      PaneLayoutCubit(store: store, initial: initial);

  setUp(() => store = FakePaneLayoutStore());

  group('PaneLayoutCubit', () {
    test('starts from the initial widths', () {
      expect(build().state, const PaneWidths());
      expect(
        build(const PaneWidths(inputs: 400)).state,
        const PaneWidths(inputs: 400),
      );
    });

    blocTest<PaneLayoutCubit, PaneWidths>(
      'dragging the inputs divider widens the inputs pane',
      build: build,
      act: (c) => c.dragInputs(50, total, dividers),
      expect: () => [const PaneWidths(inputs: 370)],
    );

    blocTest<PaneLayoutCubit, PaneWidths>(
      'dragging the results divider left widens the results pane',
      build: build,
      act: (c) => c.dragResults(-50, total, dividers),
      expect: () => [const PaneWidths(results: 410)],
    );

    test('a drag is not saved until it ends', () {
      final c = build();
      c.dragInputs(50, total, dividers);
      expect(store.saves, isEmpty);
      c.commit();
      expect(store.saves.single, c.state);
    });

    test('drags respect the minimums', () {
      final c = build();
      c.dragInputs(-999, total, dividers);
      expect(c.state.inputs, PaneLimits.minInputs);
      c.dragResults(999, total, dividers);
      expect(c.state.results, PaneLimits.minResults);
    });

    test('nudging moves one key step and saves', () {
      final c = build();
      c.nudgeInputs(1, total, dividers);
      expect(c.state.inputs, 320 + PaneLimits.keyStep);
      expect(store.saves.length, 1);
      c.nudgeInputs(-1, total, dividers);
      c.nudgeInputs(-1, total, dividers);
      expect(c.state.inputs, 320 - PaneLimits.keyStep);
      expect(store.saves.length, 3);
    });

    test('nudging the results divider right shrinks the results pane', () {
      final c = build();
      c.nudgeResults(1, total, dividers);
      expect(c.state.results, 360 - PaneLimits.keyStep);
      c.nudgeResults(-1, total, dividers);
      c.nudgeResults(-1, total, dividers);
      expect(c.state.results, 360 + PaneLimits.keyStep);
    });

    test('reset restores the defaults and forgets the saved copy', () {
      final c = build(const PaneWidths(inputs: 500, results: 450));
      c.reset();
      expect(c.state, const PaneWidths());
      expect(store.clears, 1);
      expect(store.saved, isNull);
    });
  });
}
