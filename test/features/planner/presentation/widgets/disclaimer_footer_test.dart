import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/disclaimer_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DisclaimerFooter', () {
    testWidgets('shows the rules of thumb disclaimer', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DisclaimerFooter())),
      );
      expect(find.text(PlannerNotes.disclaimer), findsOneWidget);
    });
  });
}
