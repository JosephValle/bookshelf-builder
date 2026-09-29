import 'dart:ui' as ui;

import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

ElevationPainter painter(Inputs i) =>
    ElevationPainter(planFor(i), ink: Colors.black, paper: Colors.white);

void paintOnce(ElevationPainter p, Size size) {
  final recorder = ui.PictureRecorder();
  p.paint(Canvas(recorder), size);
  recorder.endRecording().dispose();
}

void main() {
  group('ElevationPainter.paint', () {
    test('draws the default plan', () {
      paintOnce(painter(const Inputs()), const Size(800, 600));
    });

    test('draws with the wall outline set', () {
      paintOnce(
        painter(const Inputs(wallW: 120, wallH: 96, ringOffsetFromLeft: 10)),
        const Size(800, 600),
      );
    });

    test('draws a centered wall when only the wall width is set', () {
      paintOnce(painter(const Inputs(wallW: 120)), const Size(800, 600));
    });

    test('draws with only a wall height', () {
      paintOnce(painter(const Inputs(wallH: 90)), const Size(800, 600));
    });

    test('draws violations, no toe kick and the stiffener', () {
      paintOnce(
        painter(
          const Inputs(left: 8, onFloor: false, edgeStiffener: true, top: 20),
        ),
        const Size(800, 600),
      );
    });

    test('survives tiny and degenerate canvases', () {
      paintOnce(painter(const Inputs()), const Size(50, 50));
      paintOnce(painter(const Inputs()), Size.zero);
    });

    test('draws a very large ring', () {
      paintOnce(
        painter(const Inputs(windowW: 120, windowH: 96)),
        const Size(400, 300),
      );
    });
  });

  group('shouldRepaint', () {
    test('is false for identical inputs', () {
      final a = painter(const Inputs());
      final b = painter(const Inputs());
      expect(a.shouldRepaint(b), isFalse);
    });

    test('is true when the plan changes', () {
      expect(
        painter(const Inputs()).shouldRepaint(painter(const Inputs(left: 20))),
        isTrue,
      );
    });

    test('is true when the colors change', () {
      final a = painter(const Inputs());
      final b = ElevationPainter(
        planFor(),
        ink: Colors.white,
        paper: Colors.black,
      );
      expect(a.shouldRepaint(b), isTrue);
    });
  });
}
