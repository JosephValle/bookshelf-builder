import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('ElevationView', () {
    testWidgets('describes the drawing for assistive technology', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ElevationView(plan: planFor())),
        ),
      );
      expect(
        find.bySemanticsLabel('Front elevation, 76" wide by 76" tall'),
        findsOneWidget,
      );
      handle.dispose();
    });

    testWidgets('paints in the dark theme too', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(body: ElevationView(plan: planFor())),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
