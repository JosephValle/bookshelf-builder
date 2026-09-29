import 'dart:io';
import 'dart:ui' as ui;

import 'package:bookshelf_builder/app/app.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/planner/support/fake_clipboard_writer.dart';
import 'features/planner/support/fake_inputs_store.dart';
import 'features/planner/support/fake_pdf_exporter.dart';

Future<void> shot(WidgetTester tester, String name) async {
  final finder = find.descendant(
    of: find.byType(ElevationView),
    matching: find.byType(RepaintBoundary),
  );
  final boundary = tester.renderObject<RenderRepaintBoundary>(finder.first);
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    File('/private/tmp/claude-501/-Users-joseph-StudioProjects-bookshelf-builder/511f98b6-b811-4fb8-ba02-17901f7910c9/scratchpad/$name.png')
        .writeAsBytesSync(data!.buffer.asUint8List());
  });
}

void main() {
  testWidgets('visual: wall margins and gaps', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ShelfPlannerApp(
        clipboard: FakeClipboardWriter(),
        pdfExporter: FakePdfExporter(),
        store: FakeInputsStore(),
        initial: const Inputs(
          wallW: 120,
          wallH: 96,
          wallMarginLeft: 8,
          wallMarginRight: 12,
          wallMarginTop: 6,
          gapTop: 2,
          gapBottom: 1,
          gapLeft: 3,
          gapRight: 3,
        ),
      ),
    );
    await tester.pump();
    await shot(tester, 'margins');
  });
}
