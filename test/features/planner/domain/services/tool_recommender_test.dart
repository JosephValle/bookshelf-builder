import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/tool_recommendation.dart';
import 'package:bookshelf_builder/features/planner/domain/services/tool_recommender.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const recommender = ToolRecommender();

  List<ToolRecommendation> tools([Inputs i = const Inputs()]) =>
      recommender.recommend(planFor(i));

  bool has(List<ToolRecommendation> t, String text) =>
      t.any((e) => e.name.contains(text));

  group('ToolRecommender', () {
    test('always recommends the core tools', () {
      final t = tools();
      for (final name in [
        'Track saw',
        'Miter saw',
        'Cordless drill',
        'clamps',
        'Framing square',
        'Wood glue',
        'brad nailer',
        'Safety glasses',
        '4 ft level',
        'Stud finder',
        'Structural screws',
      ]) {
        expect(has(t, name), isTrue, reason: name);
      }
    });

    test('every recommendation has a name and a reason', () {
      for (final r in tools(
        const Inputs(edgeStiffener: true, onFloor: false),
      )) {
        expect(r.name, isNotEmpty);
        expect(r.reason, isNotEmpty);
      }
    });

    test('essential items come before optional ones', () {
      final t = tools();
      final firstOptional = t.indexWhere((e) => !e.essential);
      expect(firstOptional, greaterThan(0));
      expect(t.skip(firstOptional).every((e) => !e.essential), isTrue);
      expect(t.take(firstOptional).every((e) => e.essential), isTrue);
    });

    test('the saw reason mentions the sheets and rips from the plan', () {
      final p = planFor();
      final saw = recommender
          .recommend(p)
          .firstWhere((e) => e.name.contains('Track saw'));
      final sheets = p.sheets.sheets34 + p.sheets.backSheets;
      expect(saw.reason, contains('$sheets sheets'));
      expect(saw.reason, contains('${p.sheets.neededStrips} rips'));
      expect(saw.reason, contains('11 1/16"'));
    });

    test('a single sheet is not pluralized', () {
      final saw = tools(const Inputs(windowW: 12, windowH: 12))
          .firstWhere((e) => e.name.contains('Track saw'));
      expect(saw.reason, isNot(contains('1 sheets')));
    });

    test('clamp count grows for a big ring', () {
      expect(has(tools(), '6 bar'), isTrue);
      expect(
        has(tools(const Inputs(windowW: 60, windowH: 60)), '8 bar'),
        isTrue,
      );
    });

    test('a tall unit calls for a helper', () {
      expect(has(tools(), 'helper'), isFalse);
      expect(has(tools(const Inputs(windowH: 60)), 'helper'), isTrue);
    });

    test('shims are suggested only on the floor', () {
      expect(has(tools(), 'Shims'), isTrue);
      expect(has(tools(const Inputs(onFloor: false)), 'Shims'), isFalse);
    });

    test('edge band adds an optional strip tool', () {
      expect(has(tools(), 'edge band strips'), isFalse);
      final t = tools(const Inputs(edgeStiffener: true));
      final strip = t.firstWhere((e) => e.name.contains('edge band strips'));
      expect(strip.essential, isFalse);
    });

    test('nice-to-have items are marked optional', () {
      final optional = tools().where((e) => !e.essential).map((e) => e.name);
      expect(optional, contains('Pocket hole jig'));
      expect(optional.any((n) => n.contains('sander')), isTrue);
    });

    test('the stud finder mentions the stud spacing', () {
      final stud = tools().firstWhere((e) => e.name == 'Stud finder');
      expect(stud.reason, contains('16"'));
    });

    test('no text contains an em dash', () {
      for (final r in tools(const Inputs(edgeStiffener: true))) {
        expect('${r.name} ${r.reason}'.contains('\u2014'), isFalse);
      }
    });
  });

  group('concrete wall', () {
    test('a stud wall recommends a stud finder, not a hammer drill', () {
      final names = tools().map((e) => e.name);
      expect(names, contains('Stud finder'));
      expect(names.any((n) => n.contains('Hammer drill')), isFalse);
    });

    test('a concrete wall swaps the stud finder for masonry tools', () {
      final list = tools(const Inputs(concreteWall: true));
      final names = list.map((e) => e.name);
      expect(names, isNot(contains('Stud finder')));
      expect(names.any((n) => n.contains('Hammer drill')), isTrue);
      expect(names.any((n) => n.contains('Blow-out')), isTrue);
      expect(names.any((n) => n.contains('Concrete screws')), isTrue);
    });

    test('the stud finder uses the chosen stud spacing', () {
      final stud = tools(const Inputs(studSpacing: 18))
          .firstWhere((e) => e.name == 'Stud finder');
      expect(stud.reason, contains('18"'));
    });
  });
}
