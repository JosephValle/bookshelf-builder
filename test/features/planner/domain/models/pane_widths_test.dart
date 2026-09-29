import 'package:bookshelf_builder/features/planner/domain/models/pane_limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaneWidths', () {
    test('defaults to the standard layout', () {
      const w = PaneWidths();
      expect(w.inputs, PaneLimits.defaultInputs);
      expect(w.results, PaneLimits.defaultResults);
    });

    test('has value equality', () {
      expect(const PaneWidths(inputs: 300), const PaneWidths(inputs: 300));
      expect(const PaneWidths(inputs: 300), isNot(const PaneWidths()));
      expect(
        const PaneWidths(results: 400),
        isNot(const PaneWidths(results: 401)),
      );
    });
  });

  group('PaneLimits', () {
    test('defaults respect the minimums', () {
      expect(
        PaneLimits.defaultInputs,
        greaterThanOrEqualTo(PaneLimits.minInputs),
      );
      expect(
        PaneLimits.defaultResults,
        greaterThanOrEqualTo(PaneLimits.minResults),
      );
    });

    test('the three minimums fit inside the wide breakpoint', () {
      const sum =
          PaneLimits.minInputs + PaneLimits.minDrawing + PaneLimits.minResults;
      expect(sum + 24, lessThan(1000));
    });
  });
}
