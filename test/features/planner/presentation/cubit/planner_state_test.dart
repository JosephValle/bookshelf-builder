import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('PlannerState', () {
    test('has value equality including the notice', () {
      final a = PlannerState(inputs: const Inputs(), plan: planFor());
      final b = PlannerState(inputs: const Inputs(), plan: planFor());
      expect(a, b);
      expect(
        a,
        isNot(
          PlannerState(
            inputs: const Inputs(),
            plan: planFor(),
            notice: 'x',
            noticeId: 1,
          ),
        ),
      );
    });
  });
}
