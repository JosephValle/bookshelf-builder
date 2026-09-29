import 'package:bookshelf_builder/features/planner/presentation/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SectionHeading', () {
    testWidgets('renders text as a semantic header', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SectionHeading('Depth'))),
      );
      expect(find.text('Depth'), findsOneWidget);
      expect(
        tester.getSemantics(find.text('Depth')),
        matchesSemantics(label: 'Depth', isHeader: true),
      );
      handle.dispose();
    });
  });
}
