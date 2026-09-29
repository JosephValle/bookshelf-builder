import 'package:bookshelf_builder/features/planner/domain/models/assembly_step.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_guide_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const builder = AssemblyGuideBuilder();

  List<AssemblyStep> steps([Inputs i = const Inputs()]) =>
      builder.build(planFor(i));

  String textOf(AssemblyStep s) => '${s.title}\n${s.details.join('\n')}';

  String allText(List<AssemblyStep> s) => s.map(textOf).join('\n');

  bool hasStep(List<AssemblyStep> s, String title) =>
      s.any((e) => e.title == title);

  List<AssemblyStep> starting(List<AssemblyStep> s, String prefix) =>
      s.where((e) => e.title.startsWith(prefix)).toList();

  AssemblyStep step(List<AssemblyStep> s, String prefix) =>
      s.firstWhere((e) => e.title.startsWith(prefix));

  group('order', () {
    test('opens with the preparation steps', () {
      final titles = steps().map((s) => s.title).toList();
      expect(titles.take(5), [
        'Gather materials and tools',
        'Before you cut: safety and words used here',
        'Rip and cut the parts',
        'Label every piece',
        'Make the French cleat pair',
      ]);
    });

    test('closes with the wall and finish steps', () {
      final titles = steps().map((s) => s.title).toList();
      expect(titles.last, 'Finish and check');
      expect(titles[titles.length - 2], 'Mount: hang the unit');
    });

    test('phases come in build order', () {
      final titles = steps().map((s) => s.title).toList();
      int at(String prefix) => titles.indexWhere((t) => t.startsWith(prefix));
      final order = [
        at('Make the French cleat pair'),
        at('Left column: mark'),
        at('Right column: mark'),
        at('Top bar: mark'),
        at('Bottom bar: mark'),
        at('Ring: lay the top bar unit down'),
        at('Ring: check it is square'),
        at('Build the toe kick'),
        at('Flip the unit onto its front'),
        at('Back panel'),
        at('French cleat: fasten unit piece'),
        at('Mount: find the studs'),
        at('Mount: screw wall piece'),
        at('Mount: hang the unit'),
      ];
      expect(order.every((i) => i >= 0), isTrue);
      expect([...order]..sort(), order);
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
  });

  group('pieces and ids', () {
    test('a shelf step is written for every shelf, with its own piece', () {
      final p = planFor();
      final left = starting(steps(), 'Left column: attach shelf');
      expect(left.length, p.leftCol.shelves);
      final titles = left.map((s) => s.title).toSet();
      expect(titles.length, p.leftCol.shelves);
      expect(left.first.title, 'Left column: attach shelf D1 to B1');
      expect(left[1].title, 'Left column: attach shelf D2 to B1');
    });

    test('the right column uses its own pieces', () {
      final right = starting(steps(), 'Right column: attach shelf');
      expect(right.first.title, 'Right column: attach shelf D7 to B2');
    });

    test('every piece in the cut list is named somewhere in the guide', () {
      final text = allText(steps(const Inputs(edgeStiffener: true)));
      for (final p in planFor(const Inputs(edgeStiffener: true)).parts) {
        if (p.material == PartMaterial.edgeBand) continue;
        for (final id in p.ids) {
          expect(
            RegExp('\\b$id\\b').hasMatch(text),
            isTrue,
            reason: '$id (${p.name}) is never mentioned',
          );
        }
      }
    });

    test('every id used in a title exists in the plan', () {
      final p = planFor(const Inputs(left: 40, top: 20));
      final known = {for (final part in p.parts) ...part.ids};
      for (final s in builder.build(p)) {
        for (final m in RegExp(r'\b[A-Z]{1,2}\d+\b').allMatches(s.title)) {
          expect(known, contains(m.group(0)), reason: s.title);
        }
      }
    });

    test('the label step lists every part with its ids and size', () {
      final label = step(steps(), 'Label every piece');
      final text = textOf(label);
      expect(text, contains('A1: Top panel, 76" by 11 1/16"'));
      expect(text, contains('A2: Bottom panel'));
      expect(text, contains('B1-B2: Outer column panel'));
      expect(text, contains('B3-B4: Inner column panel'));
    });
  });

  group('pictures', () {
    test('joins each have a picture', () {
      for (final s in steps()) {
        final needsNone = {
          'Gather materials and tools',
          'Before you cut: safety and words used here',
          'Rip and cut the parts',
          'Label every piece',
          'Flip the unit onto its front',
          'Mount: find the studs and mark the heights',
          'Finish and check',
        };
        if (needsNone.contains(s.title)) continue;
        expect(s.diagrams, isNotEmpty, reason: s.title);
      }
    });

    test('a shelf step has a placement picture and a screw picture', () {
      expect(step(steps(), 'Left column: attach shelf D1').diagrams.length, 2);
    });
  });

  group('screws and distances', () {
    test('a shelf step gives the screw count and edge distances', () {
      final text = textOf(step(steps(), 'Left column: attach shelf D1'));
      expect(text, contains('drive 3 screws'));
      expect(text, contains('1" in from the front edge'));
      expect(text, contains('1" in from the back edge'));
      expect(text, contains('3/8" from either face'));
      expect(text, contains('pilot hole'));
    });

    test('a shallow build uses two screws and no middle screw', () {
      final text = textOf(
        step(steps(const Inputs(depth: 8)), 'Left column: attach shelf D1'),
      );
      expect(text, contains('drive 2 screws'));
      expect(text, isNot(contains('halfway')));
    });

    test('the shelf line height comes from the plan', () {
      final text = textOf(step(steps(), 'Left column: attach shelf D2'));
      expect(text, contains('19 13/16" up from the bottom end'));
    });

    test('the gather step totals the fasteners to buy', () {
      final text = textOf(step(steps(), 'Gather materials and tools'));
      expect(text, contains('1-1/4" screws:'));
      expect(text, contains('1" brad nails:'));
      expect(text, contains('2" screws for the unit cleat: 12'));
      expect(text, contains('3" screws for the wall cleat: 8'));
    });

    test('brads are placed 3/8 inch from edges and 6 inches apart', () {
      final text = textOf(step(steps(), 'Back panel'));
      expect(text, contains('3/8" in from every edge'));
      expect(text, contains('6" apart'));
    });

    test('unit cleat screws are placed from the ends', () {
      final text = textOf(step(steps(), 'French cleat: fasten unit piece'));
      expect(text, contains('2" screws'));
      expect(text, contains('1" from each end'));
    });

    test('wall cleat screws are two per stud', () {
      final text = textOf(step(steps(), 'Mount: screw wall piece'));
      expect(text, contains('3" screws'));
      expect(text, contains('two per stud'));
    });
  });

  group('columns', () {
    test('the column step shows sizes from the plan', () {
      final text = textOf(step(steps(), 'Left column: mark'));
      expect(text, contains('71 1/16"'));
      expect(text, contains('9 9/16"'));
      expect(text, contains('10 1/4"'));
    });

    test('a column with no shelves says so and has no shelf steps', () {
      final s = steps(const Inputs(targetClearH: 80));
      expect(allText(s), contains('No fixed shelves are needed'));
      expect(starting(s, 'Left column: attach shelf'), isEmpty);
    });

    test('column dividers get a step each', () {
      final p = planFor(const Inputs(left: 40));
      final c = p.leftCol;
      final s = builder.build(p);
      expect(
        starting(s, 'Left column: attach divider').length,
        c.dividers * (c.shelves + 1),
      );
    });

    test('the inner panel is attached after every shelf', () {
      final s = steps();
      final titles = s.map((e) => e.title).toList();
      final last = titles.lastIndexWhere(
        (t) => t.startsWith('Left column: attach shelf'),
      );
      expect(
        titles.indexWhere((t) => t.startsWith('Left column: attach B3')),
        greaterThan(last),
      );
    });
  });

  group('bars', () {
    test('the top bar notches its dividers for the anchor cleat', () {
      final text = textOf(step(steps(), 'Top bar: notch'));
      expect(text, contains('3/4" deep'));
      expect(text, contains('3 1/2" tall'));
    });

    test('a divider step gives its distance from the left end', () {
      final text = textOf(step(steps(), 'Top bar: attach divider'));
      expect(text, contains('from the left end'));
      expect(text, contains('on its end'));
    });

    test('bars are sized from the framed opening, not the bare window', () {
      final head = step(
        steps(const Inputs(trimLeft: 2, trimRight: 2, gapLeft: 1)),
        'Top bar: attach the head panel',
      );
      expect(textOf(head), contains('53" long'));
    });

    test('the anchor cleat is glued into the top bar', () {
      final cleat = step(steps(), 'Top bar: glue in the anchor cleat');
      expect(textOf(cleat), contains('anchor'));
      expect(textOf(cleat), contains('wall anchors bite'));
    });

    test('the top bar gets shelf steps when it is tall', () {
      final s = steps(const Inputs(top: 20));
      expect(starting(s, 'Top bar: fit shelf').isNotEmpty, isTrue);
    });

    test('a bottom bar on the floor has no anchor cleat step', () {
      expect(starting(steps(), 'Bottom bar: glue in'), isEmpty);
    });

    test('an off-floor bottom bar gets its own anchor cleat', () {
      final s = steps(const Inputs(onFloor: false));
      expect(starting(s, 'Bottom bar: glue in the anchor cleat'), hasLength(1));
    });
  });

  group('ring', () {
    test('the ring step checks the framed opening', () {
      final ring = step(
        steps(const Inputs(gapTop: 1)),
        'Ring: check it is square',
      );
      expect(textOf(ring), contains('framed opening is 48" by 49"'));
      expect(textOf(ring), contains('76" wide by 77" tall'));
    });

    test('the ring is built lying on its back', () {
      final text = textOf(step(steps(), 'Ring: lay the top bar unit down'));
      expect(text, contains('lying on its back'));
    });

    test('both columns are screwed to both long panels', () {
      final s = steps();
      expect(starting(s, 'Ring: attach the left column').length, 2);
      expect(starting(s, 'Ring: attach the right column').length, 2);
    });

    test('the materials step explains trim and gaps when present', () {
      final first = textOf(step(steps(const Inputs(trimTop: 2)), 'Gather'));
      expect(first, contains('framed opening is 48" by 50"'));
      expect(textOf(step(steps(), 'Gather')), isNot(contains('framed')));
    });
  });

  group('extras', () {
    test('the toe kick step is skipped off the floor', () {
      final off = steps(const Inputs(onFloor: false));
      expect(hasStep(off, 'Build the toe kick'), isFalse);
      expect(hasStep(off, 'Flip the unit onto its front'), isTrue);
    });

    test('the edge band step appears only with the stiffener', () {
      expect(hasStep(steps(), 'Add the front edge band'), isFalse);
      expect(
        hasStep(
          steps(const Inputs(edgeStiffener: true)),
          'Add the front edge band',
        ),
        isTrue,
      );
    });

    test('the edge band goes on before the unit is flipped', () {
      final titles = steps(const Inputs(edgeStiffener: true))
          .map((s) => s.title)
          .toList();
      expect(
        titles.indexOf('Add the front edge band'),
        lessThan(titles.indexOf('Flip the unit onto its front')),
      );
    });

    test('back panels are one step each', () {
      expect(starting(steps(), 'Back panel').length, 4);
    });

    test('the French cleat is made, fastened to the unit, then hung', () {
      final titles = steps().map((s) => s.title).toList();
      final make = titles.indexOf('Make the French cleat pair');
      final fasten = titles.indexWhere(
        (t) => t.startsWith('French cleat: fasten unit piece'),
      );
      final mount = titles.indexWhere(
        (t) => t.startsWith('Mount: screw wall piece'),
      );
      expect(make < fasten && fasten < mount, isTrue);
      expect(starting(steps(), 'French cleat: fasten').length, 4);
      expect(starting(steps(), 'Mount: screw wall piece').length, 4);
      final text = textOf(steps()[make]);
      expect(text, contains('45 degrees'));
      expect(text, contains('14", 14", 14" and 14"'));
    });

    test('the unit cleat is centered on a shelf with a height', () {
      final text = textOf(step(steps(), 'French cleat: fasten unit piece'));
      expect(text, contains('Center'));
      expect(text, contains('above the bottom of the unit'));
    });

    test('wall heights are given from the floor', () {
      final text = textOf(step(steps(), 'Mount: find the studs'));
      expect(text, contains('above the floor'));
      expect(text, contains('level line'));
    });

    test('the wall step reports the window position when a wall is set', () {
      final wall = step(
        steps(const Inputs(wallW: 120)),
        'Mount: find the studs',
      );
      expect(textOf(wall), contains('from the'));
      expect(textOf(wall), contains('36" left column'));
    });

    test('the hang step anchors through the cleat', () {
      final text = textOf(step(steps(), 'Mount: hang the unit'));
      expect(text, contains('anchor cleat'));
      expect(text, contains('never through the 1/4" back alone'));
    });

    test('safety and vocabulary are explained for beginners', () {
      final text = textOf(step(steps(), 'Before you cut'));
      expect(text, contains('safety glasses'));
      expect(text, contains('Rip means'));
      expect(text, contains('Kerf'));
      expect(text, contains('Piece ids'));
    });

    test('finish step mentions warnings only when there are some', () {
      final clean = steps().last.details.join(' ');
      expect(clean, isNot(contains('Review the warnings')));
      final warned = steps(const Inputs(left: 8)).last.details.join(' ');
      expect(warned, contains('Review the warnings'));
    });

    test('materials step lists the sheet counts', () {
      final p = planFor();
      final first = builder.build(p).first.details.first;
      expect(first, contains('${p.sheets.sheets34} sheets of 3/4"'));
    });

    test('the guide never contains an em dash', () {
      expect(
        allText(steps(const Inputs(edgeStiffener: true))).contains('—'),
        isFalse,
      );
    });
  });
}
