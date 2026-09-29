import 'package:bookshelf_builder/features/planner/domain/models/input_ranges.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InputRanges', () {
    test('every range is ordered', () {
      expect(InputRanges.windowWMin, lessThan(InputRanges.windowWMax));
      expect(InputRanges.windowHMin, lessThan(InputRanges.windowHMax));
      expect(InputRanges.sectionMin, lessThan(InputRanges.sectionMax));
      expect(InputRanges.depthMin, lessThan(InputRanges.depthMax));
      expect(InputRanges.toeKickMin, lessThan(InputRanges.toeKickMax));
      expect(InputRanges.clearHMin, lessThan(InputRanges.clearHMax));
      expect(InputRanges.shelfWidthMin, lessThan(InputRanges.shelfWidthMax));
      expect(InputRanges.marginMin, lessThan(InputRanges.marginMax));
    });

    test('depth presets are 1x8, 1x10 and 1x12 plus the back', () {
      expect(InputRanges.depthPresets, [7.25, 9.25, 11.25]);
    });

    test('shelf presets are paperback, hardcover and oversize', () {
      expect(InputRanges.clearHPresets, {
        'Paperback': 8,
        'Hardcover': 10,
        'Oversize': 13,
      });
    });
  });
}
