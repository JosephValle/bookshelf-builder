import 'package:bookshelf_builder/features/planner/domain/models/sides.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sides', () {
    test('defaults to zero on every side', () {
      const s = Sides();
      expect([s.top, s.bottom, s.left, s.right], [0, 0, 0, 0]);
    });

    test('isPaired is true when top matches bottom and left matches right', () {
      expect(const Sides().isPaired, isTrue);
      expect(
        const Sides(top: 2, bottom: 2, left: 1, right: 1).isPaired,
        isTrue,
      );
    });

    test('isPaired is false when a pair differs', () {
      expect(const Sides(top: 2, bottom: 1).isPaired, isFalse);
      expect(const Sides(left: 2, right: 1).isPaired, isFalse);
    });

    test('copyWith replaces only the given sides', () {
      final s = const Sides(top: 1).copyWith(left: 3);
      expect(s, const Sides(top: 1, left: 3));
    });

    test('has value equality', () {
      expect(const Sides(top: 1), const Sides(top: 1));
      expect(const Sides(top: 1), isNot(const Sides(bottom: 1)));
    });
  });
}
