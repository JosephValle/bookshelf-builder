import 'package:bookshelf_builder/features/planner/domain/models/tool_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ToolRecommendation', () {
    test('is essential by default', () {
      expect(
        const ToolRecommendation(name: 'a', reason: 'b').essential,
        isTrue,
      );
    });

    test('has value equality', () {
      expect(
        const ToolRecommendation(name: 'a', reason: 'b'),
        const ToolRecommendation(name: 'a', reason: 'b'),
      );
      expect(
        const ToolRecommendation(name: 'a', reason: 'b'),
        isNot(
          const ToolRecommendation(name: 'a', reason: 'b', essential: false),
        ),
      );
    });
  });
}
