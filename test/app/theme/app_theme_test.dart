import 'package:bookshelf_builder/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('builds light and dark themes', () {
      expect(AppTheme.light().brightness, Brightness.light);
      expect(AppTheme.dark().brightness, Brightness.dark);
    });

    test('input borders have an explicit outline color in both themes', () {
      for (final t in [AppTheme.light(), AppTheme.dark()]) {
        final border =
            t.inputDecorationTheme.enabledBorder! as OutlineInputBorder;
        expect(border.borderSide.color, t.colorScheme.outline);
      }
    });
  });
}
