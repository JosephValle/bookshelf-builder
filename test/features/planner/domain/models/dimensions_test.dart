import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dimensions.from', () {
    test('derives the default values', () {
      final d = Dimensions.from(const Inputs());
      expect(d.ringW, 76);
      expect(d.ringH, 76);
      expect(d.depthPanel, closeTo(11.03125, 1e-9));
      expect(d.kick, 3.5);
      expect(d.sideH, closeTo(71.0625, 1e-9));
      expect(d.spanLimit, 30);
    });

    test('kick is zero when not on the floor', () {
      final d = Dimensions.from(const Inputs(onFloor: false));
      expect(d.kick, 0);
      expect(d.sideH, closeTo(74.5625, 1e-9));
    });

    test('edge stiffener raises the span limit to 36', () {
      expect(Dimensions.from(const Inputs(edgeStiffener: true)).spanLimit, 36);
    });

    test('ring size sums columns and window', () {
      final d = Dimensions.from(
        const Inputs(left: 10, right: 12, windowW: 30, top: 9, bottom: 11),
      );
      expect(d.ringW, 52);
      expect(d.ringH, 68);
    });
  });
}
