import 'package:bookshelf_builder/features/planner/domain/models/assembly_step.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_guide_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const builder = AssemblyGuideBuilder();

  List<AssemblyStep> steps([Inputs i = const Inputs()]) =>
      builder.build(planFor(i));

  String allText(List<AssemblyStep> s) =>
      s.map((e) => '${e.title}\n${e.details.join('\n')}').join('\n');

  bool hasStep(List<AssemblyStep> s, String title) =>
      s.any((e) => e.title == title);

  group('AssemblyGuideBuilder', () {
    test('produces the standard steps in order', () {
      final titles = steps().map((s) => s.title).toList();
      expect(titles, [
        'Gather materials and tools',
        'Rip and cut the parts',
        'Build the toe kick',
        'Build the left column',
        'Build the right column',
        'Build the top bar (box beam)',
        'Build the bottom bar',
        'Assemble the ring',
        'Attach the back panels',
        'Mount to the wall',
        'Finish and check',
      ]);
    });

    test('every step has a title and details', () {
      for (final s in steps()) {
        expect(s.title, isNotEmpty);
        expect(s.details, isNotEmpty);
        for (final d in s.details) {
          expect(d, isNotEmpty);
        }
      }
    });

    test('the toe kick step is skipped off the floor', () {
      expect(hasStep(steps(const Inputs(onFloor: false)), 'Build the toe kick'),
          isFalse);
    });

    test('the edge band step appears only with the stiffener', () {
      expect(hasStep(steps(), 'Add the front edge band'), isFalse);
      expect(
        hasStep(steps(const Inputs(edgeStiffener: true)),
            'Add the front edge band'),
        isTrue,
      );
    });

    test('measurements come from the plan', () {
      final text = allText(steps());
      expect(text, contains('71 1/16"'));
      expect(text, contains('76" wide by 76" tall'));
      expect(text, contains('23 5/8"'));
      expect(text, contains('11 1/16"'));
    });

    test('shelf spacing is described for each column', () {
      final text = allText(steps());
      expect(text, contains('Mark 6 shelf positions'));
      expect(text, contains('9 9/16" clear'));
    });

    test('a column with no shelves says so', () {
      final text = allText(steps(const Inputs(targetClearH: 80)));
      expect(text, contains('No fixed shelves are needed'));
    });

    test('column dividers are explained when needed', () {
      final text = allText(steps(const Inputs(left: 40)));
      expect(text, contains('vertical divider'));
    });

    test('the anchor cleat is part of the top bar step', () {
      final top = steps().firstWhere((s) => s.title.contains('top bar'));
      expect(top.details.join(' '), contains('anchor cleat'));
    });

    test('the top bar mentions its shelf tier when tall', () {
      final top = steps(const Inputs(top: 20))
          .firstWhere((s) => s.title.contains('top bar'));
      expect(top.details.join(' '), contains('horizontal shelf per bay'));
    });

    test('an off-floor bottom bar mentions support', () {
      final bottom = steps(const Inputs(onFloor: false))
          .firstWhere((s) => s.title == 'Build the bottom bar');
      expect(bottom.details.join(' '), contains('not resting on the floor'));
    });

    test('the wall step tells you to anchor through the cleat', () {
      final wall = steps().firstWhere((s) => s.title == 'Mount to the wall');
      expect(wall.details.join(' '), contains('anchor cleat'));
      expect(wall.details.join(' '), contains('French cleat'));
    });

    test('the wall step reports the window position when a wall is set', () {
      final wall = steps(const Inputs(wallW: 120))
          .firstWhere((s) => s.title == 'Mount to the wall');
      expect(wall.details.join(' '), contains('from the'));
      expect(wall.details.join(' '), contains('36" left column'));
    });

    test('finish step mentions warnings only when there are some', () {
      final clean = steps().last.details.join(' ');
      expect(clean, isNot(contains('Review the warnings')));
      final warned = steps(const Inputs(left: 8)).last.details.join(' ');
      expect(warned, contains('Review the warnings'));
    });

    test('the guide never contains an em dash', () {
      expect(allText(steps(const Inputs(edgeStiffener: true))).contains('—'),
          isFalse);
    });

    test('materials step lists the sheet counts', () {
      final p = planFor();
      final first = builder.build(p).first.details.first;
      expect(first, contains('${p.sheets.sheets34} sheets of 3/4"'));
    });
  });
}
