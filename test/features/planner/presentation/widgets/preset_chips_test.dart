import 'package:bookshelf_builder/features/planner/presentation/widgets/preset_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PresetChips', () {
    testWidgets('marks the matching preset selected and reports taps', (
      tester,
    ) async {
      double? picked;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PresetChips(
              presets: const {'Paperback': 8, 'Hardcover': 10},
              current: 10,
              onSelected: (v) => picked = v,
            ),
          ),
        ),
      );
      final selected = tester
          .widgetList<ChoiceChip>(find.byType(ChoiceChip))
          .where((c) => c.selected)
          .toList();
      expect(selected.length, 1);
      expect(find.text('Hardcover 10"'), findsOneWidget);
      await tester.tap(find.text('Paperback 8"'));
      expect(picked, 8);
    });
  });
}
