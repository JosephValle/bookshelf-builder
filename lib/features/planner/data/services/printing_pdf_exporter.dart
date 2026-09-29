import 'package:bookshelf_builder/features/planner/data/services/pdf_document_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

/// Exports the PDF through the platform print dialog (browser print on the
/// web, system print and save on macOS).
///
/// On macOS it can also save the file through the system save panel and show
/// it in Finder, using a small native channel (see `MainFlutterWindow.swift`).
class PrintingPdfExporter implements PdfExporter {
  /// Creates an exporter. [macOs] forces the platform check, for tests.
  const PrintingPdfExporter({
    this.builder = const PdfDocumentBuilder(),
    this.channel = const MethodChannel(channelName),
    this.macOs,
  });

  /// Name of the native channel that saves files and shows them in Finder.
  static const String channelName = 'shelf_planner/files';

  /// File name suggested in the save panel.
  static const String fileName = 'shelf_planner.pdf';

  /// Builds the document bytes.
  final PdfDocumentBuilder builder;

  /// Channel to the native save panel and Finder.
  final MethodChannel channel;

  /// Overrides the platform check when not null.
  final bool? macOs;

  @override
  bool get canSave =>
      macOs ?? (!kIsWeb && defaultTargetPlatform == TargetPlatform.macOS);

  @override
  Future<void> export(Plan plan) async {
    await Printing.layoutPdf(
      name: fileName,
      onLayout: (format) => builder.build(plan),
    );
  }

  @override
  Future<String?> save(Plan plan) async {
    if (!canSave) return null;
    final bytes = await builder.build(plan);
    return channel.invokeMethod<String>('savePdf', {
      'bytes': bytes,
      'name': fileName,
    });
  }

  @override
  Future<void> reveal(String path) async {
    if (!canSave) return;
    await channel.invokeMethod<void>('reveal', {'path': path});
  }
}
