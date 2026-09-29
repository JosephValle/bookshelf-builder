import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:flutter/material.dart';

/// Buttons for copying the cut list and summary, saving the PDF where the
/// platform allows it, and exporting the PDF.
class ActionBar extends StatelessWidget {
  /// Creates the bar.
  const ActionBar({
    required this.onCopyCsv,
    required this.onCopySummary,
    required this.onExportPdf,
    this.onSavePdf,
    super.key,
  });

  /// Copy the cut list as CSV.
  final VoidCallback onCopyCsv;

  /// Copy the plain text summary.
  final VoidCallback onCopySummary;

  /// Export the printable PDF.
  final VoidCallback onExportPdf;

  /// Save the PDF to a file and offer to show it in the file manager. Null
  /// hides the button (the platform cannot do it).
  final VoidCallback? onSavePdf;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Space.md),
      child: Wrap(
        spacing: Space.sm,
        runSpacing: Space.sm,
        children: [
          OutlinedButton.icon(
            onPressed: onCopyCsv,
            icon: const Icon(Icons.table_chart_outlined),
            label: const Text('Copy CSV'),
          ),
          OutlinedButton.icon(
            onPressed: onCopySummary,
            icon: const Icon(Icons.copy),
            label: const Text('Copy summary'),
          ),
          if (onSavePdf != null)
            OutlinedButton.icon(
              onPressed: onSavePdf,
              icon: const Icon(Icons.save_alt),
              label: const Text('Save PDF'),
            ),
          FilledButton.icon(
            onPressed: onExportPdf,
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Export PDF'),
          ),
        ],
      ),
    );
  }
}
