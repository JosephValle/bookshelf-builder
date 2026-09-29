import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cut_list_csv_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const builder = CutListCsvBuilder();

  group('build', () {
    test('starts with the header row', () {
      expect(
        builder.build(planFor()).split('\n').first,
        'Piece,Part,Qty,Length,Width,Material',
      );
    });

    test('has one row per part', () {
      final p = planFor();
      final lines = builder.build(p).trim().split('\n');
      expect(lines.length, p.parts.length + 1);
    });

    test('formats a known row and escapes inch marks', () {
      expect(
        builder.build(planFor()),
        contains('"A1","Top panel",1,"76""","11 1/16""","3/4"" plywood"'),
      );
    });

    test('edge band row has feet and no width', () {
      final csv = builder.build(planFor(const Inputs(edgeStiffener: true)));
      final row = csv.trim().split('\n').last;
      expect(row, contains(' ft'));
      expect(row, contains('"",'));
    });
  });
}
