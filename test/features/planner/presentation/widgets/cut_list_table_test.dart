import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/cut_list_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('CutListTable', () {
    testWidgets('lists every part with its length', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CutListTable(plan: planFor())),
        ),
      );
      expect(find.text('Top panel'), findsOneWidget);
      expect(find.text('Toe kick'), findsOneWidget);
      expect(find.text('71 1/16"'), findsWidgets);
      expect(find.text('Qty'), findsOneWidget);
    });

    testWidgets('shows edge band in feet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CutListTable(
              plan: planFor(const Inputs(edgeStiffener: true)),
            ),
          ),
        ),
      );
      expect(find.text('Front edge band (total)'), findsOneWidget);
      expect(find.textContaining(' ft'), findsOneWidget);
    });
  });
}
