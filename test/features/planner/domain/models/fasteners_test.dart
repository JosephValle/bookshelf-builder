import 'package:bookshelf_builder/features/planner/domain/models/fasteners.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fasteners', () {
    test('a shallow panel gets two screws per joint', () {
      expect(Fasteners.screwsPerJoint(7.25), 2);
      expect(Fasteners.screwsPerJoint(9), 2);
    });

    test('a deeper panel gets a third, middle screw', () {
      expect(Fasteners.screwsPerJoint(9.5), 3);
      expect(Fasteners.screwsPerJoint(16), 3);
    });

    test('the rules of thumb are the documented ones', () {
      expect(Fasteners.edgeInset, 1);
      expect(Fasteners.screwSpacing, 6);
      expect(Fasteners.nailSpacing, 6);
      expect(Fasteners.nailInset, 0.375);
    });
  });
}
