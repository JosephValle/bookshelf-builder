import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pane_layout_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calc = PaneLayoutCalculator();
  const dividers = 24.0;

  group('fit', () {
    test('leaves comfortable widths alone', () {
      const w = PaneWidths(inputs: 320, results: 360);
      expect(calc.fit(w, 1600, dividers), w);
    });

    test('raises widths below the minimums', () {
      final f = calc.fit(
        const PaneWidths(inputs: 10, results: 10),
        1600,
        dividers,
      );
      expect(f.inputs, PaneLimits.minInputs);
      expect(f.results, PaneLimits.minResults);
    });

    test('never lets the drawing drop below its minimum', () {
      final f = calc.fit(
        const PaneWidths(inputs: 900, results: 900),
        1400,
        dividers,
      );
      expect(calc.drawing(f, 1400, dividers), greaterThanOrEqualTo(320));
      expect(f.inputs, greaterThanOrEqualTo(PaneLimits.minInputs));
      expect(f.results, greaterThanOrEqualTo(PaneLimits.minResults));
    });

    test('shrinks side panes when the window shrinks', () {
      const w = PaneWidths(inputs: 500, results: 500);
      final wide = calc.fit(w, 2000, dividers);
      final narrow = calc.fit(w, 1100, dividers);
      expect(wide, w);
      expect(narrow.inputs + narrow.results, lessThan(1000));
      expect(calc.drawing(narrow, 1100, dividers), greaterThanOrEqualTo(320));
    });

    test('grows the drawing when the window grows', () {
      const w = PaneWidths();
      final a = calc.drawing(calc.fit(w, 1200, dividers), 1200, dividers);
      final b = calc.drawing(calc.fit(w, 1800, dividers), 1800, dividers);
      expect(b - a, closeTo(600, 1e-9));
    });

    test('the minimums win when the window is too small for everything', () {
      final f = calc.fit(const PaneWidths(), 500, dividers);
      expect(f.inputs, PaneLimits.minInputs);
      expect(f.results, PaneLimits.minResults);
    });

    test('at exactly the smallest supported width all minimums fit', () {
      const total = 260 + 320 + 300 + dividers;
      final f = calc.fit(const PaneWidths(), total, dividers);
      expect(f.inputs, 260);
      expect(f.results, 300);
      expect(calc.drawing(f, total, dividers), 320);
    });
  });

  group('dragInputs', () {
    test('moving right widens the inputs pane', () {
      final w = calc.dragInputs(const PaneWidths(), 40, 1600, dividers);
      expect(w.inputs, 360);
      expect(w.results, 360);
    });

    test('moving left narrows it', () {
      final w = calc.dragInputs(const PaneWidths(), -30, 1600, dividers);
      expect(w.inputs, 290);
    });

    test('stops at the minimum', () {
      final w = calc.dragInputs(const PaneWidths(), -500, 1600, dividers);
      expect(w.inputs, PaneLimits.minInputs);
    });

    test('stops when the drawing reaches its minimum', () {
      final w = calc.dragInputs(const PaneWidths(), 2000, 1400, dividers);
      expect(calc.drawing(w, 1400, dividers), 320);
      expect(w.results, PaneLimits.minResults);
    });

    test('does not change the results pane width', () {
      final w = calc.dragInputs(const PaneWidths(), 25, 1600, dividers);
      expect(w.results, 360);
    });
  });

  group('dragResults', () {
    test('moving left widens the results pane', () {
      final w = calc.dragResults(const PaneWidths(), -40, 1600, dividers);
      expect(w.results, 400);
      expect(w.inputs, 320);
    });

    test('moving right narrows it', () {
      final w = calc.dragResults(const PaneWidths(), 30, 1600, dividers);
      expect(w.results, 330);
    });

    test('stops at the minimum', () {
      final w = calc.dragResults(const PaneWidths(), 900, 1600, dividers);
      expect(w.results, PaneLimits.minResults);
    });

    test('stops when the drawing reaches its minimum', () {
      final w = calc.dragResults(const PaneWidths(), -2000, 1400, dividers);
      expect(calc.drawing(w, 1400, dividers), 320);
      expect(w.inputs, 320);
    });
  });
}
