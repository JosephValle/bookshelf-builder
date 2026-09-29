import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_shape.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_tone.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiagramShape', () {
    test('rect makes four corners, clockwise from the top left', () {
      final s = DiagramShape.rect(1, 2, 10, 20);
      expect(s.points, const [
        DiagramPoint(1, 2),
        DiagramPoint(11, 2),
        DiagramPoint(11, 22),
        DiagramPoint(1, 22),
      ]);
    });

    test('center is the middle of a rectangle', () {
      final c = DiagramShape.rect(0, 0, 10, 20).center;
      expect(c.x, 5);
      expect(c.y, 10);
    });

    test('center averages the corners of any polygon', () {
      const s = DiagramShape([
        DiagramPoint(0, 0),
        DiagramPoint(6, 0),
        DiagramPoint(0, 3),
      ]);
      expect(s.center, const DiagramPoint(2, 1));
    });

    test('defaults to a plain panel with no label', () {
      final s = DiagramShape.rect(0, 0, 1, 1);
      expect(s.tone, DiagramTone.panel);
      expect(s.label, isEmpty);
    });

    test('label and tone are part of equality', () {
      expect(
        DiagramShape.rect(0, 0, 1, 1, label: 'A'),
        DiagramShape.rect(0, 0, 1, 1, label: 'A'),
      );
      expect(
        DiagramShape.rect(0, 0, 1, 1, label: 'A'),
        isNot(DiagramShape.rect(0, 0, 1, 1, label: 'B')),
      );
      expect(
        DiagramShape.rect(0, 0, 1, 1),
        isNot(DiagramShape.rect(0, 0, 1, 1, tone: DiagramTone.ghost)),
      );
    });
  });
}
