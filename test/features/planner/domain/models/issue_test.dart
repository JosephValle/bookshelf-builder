import 'package:bookshelf_builder/features/planner/domain/models/issue.dart';
import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Issue', () {
    test('has value equality', () {
      expect(
        const Issue(Severity.error, 'x'),
        const Issue(Severity.error, 'x'),
      );
      expect(
        const Issue(Severity.error, 'x'),
        isNot(const Issue(Severity.note, 'x')),
      );
    });
  });
}
