import 'package:bookshelf_builder/app/theme/app_colors.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_styles.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PdfStyles', () {
    test('the accent matches the app wood color', () {
      expect(
        PdfStyles.accent.toInt(),
        AppColors.wood.toARGB32() & 0xFFFFFF | 0xFF000000,
      );
    });

    test('the total style is larger than the body style', () {
      expect(PdfStyles.total.fontSize!, greaterThan(PdfStyles.body.fontSize!));
    });

    test('the card title is bold and larger than body text', () {
      expect(
        PdfStyles.cardTitle.fontSize!,
        greaterThan(PdfStyles.body.fontSize!),
      );
    });

    test('captions are smaller than body text', () {
      expect(PdfStyles.caption.fontSize!, lessThan(PdfStyles.body.fontSize!));
    });

    test('the corner radius is positive', () {
      expect(PdfStyles.radius, greaterThan(0));
    });
  });
}
