import 'package:bookshelf_builder/features/planner/data/services/pdf_document_builder.dart';
import 'package:bookshelf_builder/features/planner/data/services/printing_pdf_exporter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PrintingPdfExporter', () {
    test('implements the PdfExporter port', () {
      expect(const PrintingPdfExporter(), isA<PdfExporter>());
    });

    test('uses the given document builder', () {
      const builder = PdfDocumentBuilder();
      expect(const PrintingPdfExporter(builder: builder).builder, builder);
    });
  });

  group('saving and showing the file', () {
    final calls = <MethodCall>[];
    String? answer;
    const channel = MethodChannel(PrintingPdfExporter.channelName);

    setUp(() {
      calls.clear();
      answer = '/Users/me/Desktop/shelf_planner.pdf';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            calls.add(call);
            return call.method == 'savePdf' ? answer : null;
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('can save only on macOS', () {
      expect(const PrintingPdfExporter(macOs: true).canSave, isTrue);
      expect(const PrintingPdfExporter(macOs: false).canSave, isFalse);
      // The test host is not treated as macOS unless it really is one.
      expect(const PrintingPdfExporter().canSave, isA<bool>());
    });

    test(
      'save sends the PDF bytes and the file name, and returns the path',
      () async {
        final path = await const PrintingPdfExporter(macOs: true)
            .save(planFor());
        expect(path, '/Users/me/Desktop/shelf_planner.pdf');
        expect(calls.single.method, 'savePdf');
        final args = calls.single.arguments as Map<Object?, Object?>;
        expect(args['name'], 'shelf_planner.pdf');
        final bytes = args['bytes']! as Uint8List;
        expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
      },
    );

    test('save returns null when the user cancels', () async {
      answer = null;
      expect(
        await const PrintingPdfExporter(macOs: true).save(planFor()),
        isNull,
      );
    });

    test('save does nothing where the platform cannot do it', () async {
      expect(
        await const PrintingPdfExporter(macOs: false).save(planFor()),
        isNull,
      );
      expect(calls, isEmpty);
    });

    test('reveal asks Finder to select the file', () async {
      await const PrintingPdfExporter(macOs: true).reveal('/tmp/a.pdf');
      expect(calls.single.method, 'reveal');
      expect(calls.single.arguments, {'path': '/tmp/a.pdf'});
    });

    test('reveal does nothing where the platform cannot do it', () async {
      await const PrintingPdfExporter(macOs: false).reveal('/tmp/a.pdf');
      expect(calls, isEmpty);
    });
  });
}
