import 'dart:async';

import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pane_layout_calculator.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pane_layout_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Holds the preferred pane widths, applies divider drags and saves the result
/// so a refresh keeps the layout.
class PaneLayoutCubit extends Cubit<PaneWidths> {
  /// Creates a cubit starting from [initial].
  PaneLayoutCubit({
    required this._store,
    PaneWidths initial = const PaneWidths(),
    this._calculator = const PaneLayoutCalculator(),
  }) : super(initial);

  final PaneLayoutStore _store;
  final PaneLayoutCalculator _calculator;

  /// Moves the inputs divider by [delta] pixels. Not saved until [commit].
  void dragInputs(double delta, double total, double dividers) =>
      emit(_calculator.dragInputs(state, delta, total, dividers));

  /// Moves the results divider by [delta] pixels. Not saved until [commit].
  void dragResults(double delta, double total, double dividers) =>
      emit(_calculator.dragResults(state, delta, total, dividers));

  /// Moves the inputs divider one key step left (-1) or right (1) and saves.
  void nudgeInputs(int direction, double total, double dividers) {
    dragInputs(direction * PaneLimits.keyStep, total, dividers);
    commit();
  }

  /// Moves the results divider one key step left (-1) or right (1) and saves.
  void nudgeResults(int direction, double total, double dividers) {
    dragResults(direction * PaneLimits.keyStep, total, dividers);
    commit();
  }

  /// Saves the current widths (call when a drag ends).
  void commit() => unawaited(_store.save(state));

  /// Restores the default widths and forgets the saved copy.
  void reset() {
    emit(const PaneWidths());
    unawaited(_store.clear());
  }
}
