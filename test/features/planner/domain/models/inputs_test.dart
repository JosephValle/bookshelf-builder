import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sides.dart';
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
      expect(r.left, 18);
      expect(r.right, 18);
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

    test('every field takes part in equality', () {
      const base = Inputs();
      final changed = <String, Inputs>{
        'windowW': base.copyWith(windowW: 49),
        'windowH': base.copyWith(windowH: 49),
        'left': base.copyWith(left: 15),
        'right': base.copyWith(right: 15),
        'top': base.copyWith(top: 15),
        'bottom': base.copyWith(bottom: 15),
        'depth': base.copyWith(depth: 9.25),
        'onFloor': base.copyWith(onFloor: false),
        'toeKick': base.copyWith(toeKick: 4),
        'targetClearH': base.copyWith(targetClearH: 8),
        'edgeStiffener': base.copyWith(edgeStiffener: true),
        'maxShelfWidth': base.copyWith(maxShelfWidth: 18),
        'fillWall': base.copyWith(fillWall: false),
        'wallW': base.copyWith(wallW: () => 100),
        'wallH': base.copyWith(wallH: () => 96),
        'wallMarginTop': base.copyWith(wallMarginTop: 1),
        'wallMarginLeft': base.copyWith(wallMarginLeft: 1),
        'wallMarginRight': base.copyWith(wallMarginRight: 1),
        'windowFromWallLeft': base.copyWith(windowFromWallLeft: () => 5),
        'windowFromFloor': base.copyWith(windowFromFloor: () => 5),
        'trimTop': base.copyWith(trimTop: 1),
        'trimBottom': base.copyWith(trimBottom: 1),
        'trimLeft': base.copyWith(trimLeft: 1),
        'trimRight': base.copyWith(trimRight: 1),
        'gapTop': base.copyWith(gapTop: 1),
        'gapBottom': base.copyWith(gapBottom: 1),
        'gapLeft': base.copyWith(gapLeft: 1),
        'gapRight': base.copyWith(gapRight: 1),
      };
      for (final e in changed.entries) {
        expect(e.value, isNot(base), reason: '${e.key} is missing from props');
      }
      expect(changed.length, base.props.length);
    });

    test('has value equality', () {
      expect(const Inputs(), const Inputs());
      expect(const Inputs(), isNot(const Inputs(windowW: 49)));
    });

    test('trim and gaps default to zero', () {
      const i = Inputs();
      expect(i.trim, const Sides());
      expect(i.gap, const Sides());
      expect(i.openW, 48);
      expect(i.openH, 48);
    });

    test('the opening is the window plus trim and gaps on each side', () {
      const i = Inputs(
        trimLeft: 2,
        trimRight: 3,
        gapLeft: 1,
        gapRight: 0.5,
        trimTop: 1,
        trimBottom: 2,
        gapTop: 0.25,
        gapBottom: 0.75,
      );
      expect(i.openW, 48 + 2 + 3 + 1 + 0.5);
      expect(i.openH, 48 + 1 + 2 + 0.25 + 0.75);
    });

    test('insets are trim plus gap on each side', () {
      const i = Inputs(trimLeft: 2, gapLeft: 1, trimTop: 3, gapTop: 0.5);
      expect(i.insetLeft, 3);
      expect(i.insetTop, 3.5);
      expect(i.insetRight, 0);
      expect(i.insetBottom, 0);
    });

    test('trim and gap getters return the four sides', () {
      const i = Inputs(trimTop: 1, trimBottom: 2, trimLeft: 3, trimRight: 4);
      expect(i.trim, const Sides(top: 1, bottom: 2, left: 3, right: 4));
    });

    test('copyWith changes trim and gaps', () {
      final i = const Inputs().copyWith(trimTop: 1, gapRight: 2);
      expect(i.trimTop, 1);
      expect(i.gapRight, 2);
      expect(i.trimBottom, 0);
    });

    test('the window is kept clear of the margin by its trim and gap', () {
      const i = Inputs(
        wallW: 120,
        wallMarginLeft: 10,
        trimLeft: 2,
        gapLeft: 1,
        windowFromWallLeft: 0,
      );
      expect(i.windowLeftOnWall, 13);
    });

    test('resolved leaves room for trim on both sides of the window', () {
      const i = Inputs(wallW: 120, trimLeft: 3, trimRight: 3);
      final r = i.resolved;
      expect(r.left + i.openW + r.right, 120);
      expect(r.left, r.right);
    });

    test('vertical: usableWallH subtracts the top margin', () {
      expect(const Inputs().usableWallH, isNull);
      expect(const Inputs(wallH: 96, wallMarginTop: 6).usableWallH, 90);
      expect(const Inputs(wallH: 10, wallMarginTop: 20).usableWallH, 0);
    });

    test('vertical: the window is centered under the top margin', () {
      expect(const Inputs(wallH: 96).windowBottomOnWall, 24);
      expect(const Inputs(wallH: 96, wallMarginTop: 12).windowBottomOnWall, 18);
    });

    test('vertical: an explicit height above the floor is honored', () {
      expect(
        const Inputs(wallH: 96, windowFromFloor: 30).windowBottomOnWall,
        30,
      );
    });

    test(
      'vertical: the opening stays under the top margin and off the floor',
      () {
        expect(
          const Inputs(wallH: 96, windowFromFloor: 90).windowBottomOnWall,
          48,
        );
        expect(
          const Inputs(
            wallH: 96,
            gapBottom: 2,
            windowFromFloor: 0,
          ).windowBottomOnWall,
          2,
        );
      },
    );

    test('resolved grows the bars to fill the wall height', () {
      final r = const Inputs(wallH: 96).resolved;
      expect(r.bottom, 24);
      expect(r.top, 24);
      expect(r.bottom + r.windowH + r.top, 96);
    });

    test('resolved moves the window up and down', () {
      final r = const Inputs(wallH: 96, windowFromFloor: 10).resolved;
      expect(r.bottom, 10);
      expect(r.top, 38);
    });

    test('resolved stops the ring under the top margin', () {
      final r = const Inputs(wallH: 96, wallMarginTop: 6).resolved;
      expect(r.bottom + r.windowH + r.top, 90);
    });

    test('resolved accounts for trim and gaps vertically', () {
      const i = Inputs(wallH: 96, trimTop: 2, trimBottom: 2, gapTop: 1);
      final r = i.resolved;
      expect(r.bottom + i.openH + r.top, 96);
    });

    test('resolved does both axes at once', () {
      final r = const Inputs(wallW: 120, wallH: 96).resolved;
      expect(r.left + r.windowW + r.right, 120);
      expect(r.bottom + r.windowH + r.top, 96);
    });

    test('resolved does nothing vertically without fillWall', () {
      const i = Inputs(wallH: 96, fillWall: false);
      expect(i.resolved.top, 14);
      expect(i.resolved.bottom, 14);
    });
  });
}
