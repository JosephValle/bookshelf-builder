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
      expect(i.maxShelfWidth, 24);
      expect(i.fillWall, isTrue);
      expect(i.windowFromWallLeft, isNull);
      expect(i.wallMarginTop, 0);
      expect(i.wallMarginLeft, 0);
      expect(i.wallMarginRight, 0);
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

    test('copyWith sets and clears the window position', () {
      final set = const Inputs().copyWith(windowFromWallLeft: () => 10);
      expect(set.windowFromWallLeft, 10);
      expect(
        set.copyWith(windowFromWallLeft: () => null).windowFromWallLeft,
        isNull,
      );
    });

    test('copyWith changes the shelf width and fill wall flag', () {
      final i = const Inputs().copyWith(maxShelfWidth: 18, fillWall: false);
      expect(i.maxShelfWidth, 18);
      expect(i.fillWall, isFalse);
    });

    test('usableWallW is null without a wall width', () {
      expect(const Inputs().usableWallW, isNull);
    });

    test('usableWallW subtracts the side margins', () {
      const i = Inputs(wallW: 100, wallMarginLeft: 6, wallMarginRight: 10);
      expect(i.usableWallW, 84);
    });

    test('usableWallW is never negative', () {
      const i = Inputs(wallW: 10, wallMarginLeft: 8, wallMarginRight: 8);
      expect(i.usableWallW, 0);
    });

    test('the window is centered between the margins', () {
      const i = Inputs(wallW: 100, wallMarginLeft: 4, wallMarginRight: 20);
      expect(i.windowLeftOnWall, 4 + (76 - 48) / 2);
    });

    test('the window cannot be moved into a margin', () {
      const i = Inputs(
        wallW: 100,
        wallMarginLeft: 10,
        wallMarginRight: 10,
        windowFromWallLeft: 2,
      );
      expect(i.windowLeftOnWall, 10);
      const j = Inputs(
        wallW: 100,
        wallMarginLeft: 10,
        wallMarginRight: 10,
        windowFromWallLeft: 90,
      );
      expect(j.windowLeftOnWall, 42);
    });

    test('resolved runs the ring from margin to margin', () {
      const i = Inputs(wallW: 100, wallMarginLeft: 6, wallMarginRight: 10);
      final r = i.resolved;
      expect(r.left, 14);
      expect(r.right, 22);
      expect(6 + r.left + r.windowW + r.right, 90);
    });

    test('copyWith changes the wall margins', () {
      final i = const Inputs().copyWith(
        wallMarginTop: 3,
        wallMarginLeft: 4,
        wallMarginRight: 5,
      );
      expect(i.wallMarginTop, 3);
      expect(i.wallMarginLeft, 4);
      expect(i.wallMarginRight, 5);
    });

    test('windowLeftOnWall is null without a wall width', () {
      expect(const Inputs().windowLeftOnWall, isNull);
    });

    test('windowLeftOnWall centers the window by default', () {
      expect(const Inputs(wallW: 120).windowLeftOnWall, 36);
    });

    test('windowLeftOnWall honors the user position', () {
      expect(
        const Inputs(wallW: 120, windowFromWallLeft: 10).windowLeftOnWall,
        10,
      );
    });

    test('windowLeftOnWall is kept within the wall', () {
      expect(
        const Inputs(wallW: 100, windowFromWallLeft: 90).windowLeftOnWall,
        52,
      );
      expect(
        const Inputs(wallW: 100, windowFromWallLeft: 0).windowLeftOnWall,
        0,
      );
    });

    test(
      'windowLeftOnWall is zero when the wall is narrower than the window',
      () {
        expect(const Inputs(wallW: 30).windowLeftOnWall, 0);
      },
    );

    test('effectiveRingOffset is null without a wall width', () {
      expect(const Inputs().effectiveRingOffset, isNull);
    });

    test('effectiveRingOffset places the window where asked', () {
      const uneven = Inputs(wallW: 120, left: 20, right: 10);
      expect(uneven.effectiveRingOffset, 16);
      expect(
        uneven.effectiveRingOffset! + uneven.left + uneven.windowW / 2,
        60,
      );
    });

    test('resolved is unchanged without a wall width', () {
      expect(const Inputs().resolved, const Inputs());
    });

    test('resolved is unchanged when fillWall is off', () {
      const i = Inputs(wallW: 120, fillWall: false);
      expect(i.resolved, i);
    });

    test('resolved grows the columns to fill a centered wall', () {
      final r = const Inputs(wallW: 120).resolved;
      expect(r.left, 36);
      expect(r.right, 36);
      expect(r.left + r.windowW + r.right, 120);
    });

    test('resolved moves the window along the wall', () {
      final r = const Inputs(wallW: 120, windowFromWallLeft: 10).resolved;
      expect(r.left, 10);
      expect(r.right, 62);
    });

    test('resolved never makes a negative column', () {
      final r = const Inputs(wallW: 30).resolved;
      expect(r.left, 0);
      expect(r.right, 0);
    });

    test('has value equality', () {
      expect(const Inputs(), const Inputs());
      expect(const Inputs(), isNot(const Inputs(windowW: 49)));
    });
  });
}
