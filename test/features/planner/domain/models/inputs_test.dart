import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Inputs', () {
    test('has the documented defaults', () {
      const i = Inputs();
      expect(i.windowW, 48);
      expect(i.windowH, 48);
      expect(i.left, 14);
      expect(i.right, 14);
      expect(i.top, 14);
      expect(i.bottom, 14);
      expect(i.depth, 11.25);
      expect(i.onFloor, isTrue);
      expect(i.toeKick, 3.5);
      expect(i.targetClearH, 11);
      expect(i.edgeStiffener, isFalse);
      expect(i.wallW, isNull);
      expect(i.wallH, isNull);
      expect(i.ringOffsetFromLeft, isNull);
    });

    test('copyWith replaces only the given fields', () {
      final i = const Inputs().copyWith(windowW: 60, onFloor: false);
      expect(i.windowW, 60);
      expect(i.onFloor, isFalse);
      expect(i.windowH, 48);
    });

    test('copyWith sets and clears optional wall fields', () {
      final set = const Inputs().copyWith(wallW: () => 120, wallH: () => 96);
      expect(set.wallW, 120);
      expect(set.wallH, 96);
      final cleared = set.copyWith(wallW: () => null);
      expect(cleared.wallW, isNull);
      expect(cleared.wallH, 96);
    });

    test('ringOffsetFromLeft can be set and cleared', () {
      final set = const Inputs().copyWith(ringOffsetFromLeft: () => 10);
      expect(set.ringOffsetFromLeft, 10);
      expect(
        set.copyWith(ringOffsetFromLeft: () => null).ringOffsetFromLeft,
        isNull,
      );
    });

    test('effectiveRingOffset is null without a wall width', () {
      expect(const Inputs().effectiveRingOffset, isNull);
    });

    test('effectiveRingOffset centers the window on the wall', () {
      expect(const Inputs(wallW: 120).effectiveRingOffset, 22);
      const uneven = Inputs(wallW: 120, left: 20, right: 10);
      expect(uneven.effectiveRingOffset, 16);
      expect(
        uneven.effectiveRingOffset! + uneven.left + uneven.windowW / 2,
        60,
      );
    });

    test('effectiveRingOffset prefers an explicit offset', () {
      expect(
        const Inputs(wallW: 120, ringOffsetFromLeft: 5).effectiveRingOffset,
        5,
      );
    });

    test('has value equality', () {
      expect(const Inputs(), const Inputs());
      expect(const Inputs(), isNot(const Inputs(windowW: 49)));
    });
  });
}
