import 'package:bookshelf_builder/features/planner/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget host({ThemeData? theme}) => MaterialApp(
    theme: theme,
    home: const Scaffold(
      body: SectionCard(
        title: 'Plywood',
        icon: Icons.layers_outlined,
        child: Text('body text'),
      ),
    ),
  );

  group('SectionCard', () {
    testWidgets('shows the icon, title and content', (tester) async {
      await tester.pumpWidget(host());
      expect(find.text('Plywood'), findsOneWidget);
      expect(find.text('body text'), findsOneWidget);
      expect(find.byIcon(Icons.layers_outlined), findsOneWidget);
    });

    testWidgets('the title is a semantic heading', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(host());
      final data = tester.getSemantics(find.text('Plywood')).getSemanticsData();
      expect(data.flagsCollection.isHeader, isTrue);
      expect(data.label, contains('Plywood'));
      handle.dispose();
    });

    testWidgets('draws an outlined card', (tester) async {
      await tester.pumpWidget(host());
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, 0);
      final shape = card.shape! as RoundedRectangleBorder;
      expect(shape.side.width, greaterThan(0));
    });

    testWidgets('works in the dark theme', (tester) async {
      await tester.pumpWidget(host(theme: ThemeData.dark()));
      expect(tester.takeException(), isNull);
    });
  });
}
