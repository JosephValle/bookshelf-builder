import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/wall_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WallInputs', () {
    testWidgets('editing and clearing update the inputs', (tester) async {
      var current = const Inputs();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => WallInputs(
                inputs: current,
                onChanged: (i) => setState(() => current = i),
              ),
            ),
          ),
        ),
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Wall width'),
        '120',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Wall height'),
        '96',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Ring offset from left'),
        '12',
      );
      expect(current.wallW, 120);
      expect(current.wallH, 96);
      expect(current.ringOffsetFromLeft, 12);
      await tester.enterText(find.widgetWithText(TextField, 'Wall width'), '');
      expect(current.wallW, isNull);
    });
  });
}
