import 'package:bookshelf_builder/features/planner/domain/services/strip_packer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const packer = StripPacker();

  group('pack', () {
    test('empty list needs no strips', () {
      expect(packer.pack([]), 0);
    });

    test('one short part uses one strip', () {
      expect(packer.pack([10]), 1);
    });

    test('small parts share a strip', () {
      expect(packer.pack([10, 10, 10]), 1);
    });

    test('two long parts need two strips', () {
      expect(packer.pack([76, 76]), 2);
    });

    test('a short part fills the gap beside a long one', () {
      expect(packer.pack([76, 12]), 1);
    });

    test('kerf between parts is counted', () {
      expect(packer.pack([48, 47.9]), 2);
      expect(packer.pack([48, 47.5]), 1);
    });

    test('input order does not matter', () {
      expect(packer.pack([12, 76, 12, 76]), packer.pack([76, 76, 12, 12]));
    });
  });
}
