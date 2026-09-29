import 'package:bookshelf_builder/features/planner/domain/models/issue.dart';
import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/issues_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IssuesList', () {
    testWidgets('says so when there are no issues', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: IssuesList(issues: [])),
        ),
      );
      expect(find.text('No warnings or errors.'), findsOneWidget);
    });

    testWidgets('shows a text label and icon per severity', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: IssuesList(
              issues: [
                Issue(Severity.error, 'bad'),
                Issue(Severity.warning, 'careful'),
                Issue(Severity.note, 'fyi'),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('Note'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
      expect(find.text('bad'), findsOneWidget);
    });
  });
}
