import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/bay.dart';
import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sheet_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Box, Bay, Part, ColumnPlan, BarPlan and SheetPlan have value equality',
    () {
      expect(const Box(1, 2, 3, 4), const Box(1, 2, 3, 4));
      expect(const Box(1, 2, 3, 4), isNot(const Box(1, 2, 3, 5)));
      expect(
        const Bay(Box(0, 0, 1, 1), true),
        const Bay(Box(0, 0, 1, 1), true),
      );
      expect(
        const Part('a', 1, 2, 3, PartMaterial.ply34),
        const Part('a', 1, 2, 3, PartMaterial.ply34),
      );
      expect(
        const ColumnPlan(
          colW: 1,
          clearW: 2,
          shelves: 3,
          clearH: 4,
          dividers: 5,
          bayW: 6,
        ),
        const ColumnPlan(
          colW: 1,
          clearW: 2,
          shelves: 3,
          clearH: 4,
          dividers: 5,
          bayW: 6,
        ),
      );
      expect(
        const BarPlan(
          dividers: 1,
          dividerLength: 2,
          bayW: 3,
          clearH: 4,
          tiers: 1,
        ),
        const BarPlan(
          dividers: 1,
          dividerLength: 2,
          bayW: 3,
          clearH: 4,
          tiers: 1,
        ),
      );
      expect(
        const SheetPlan(
          stripsPerSheet: 4,
          neededStrips: 5,
          sheets34: 2,
          backArea: 10,
          backSheets: 1,
        ),
        const SheetPlan(
          stripsPerSheet: 4,
          neededStrips: 5,
          sheets34: 2,
          backArea: 10,
          backSheets: 1,
        ),
      );
    },
  );
}
