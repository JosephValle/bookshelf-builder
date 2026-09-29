import 'dart:math' as math;

import 'package:bookshelf_builder/app/theme/app_colors.dart';
import 'package:bookshelf_builder/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

double ratio(Color a, Color b) {
  double lum(Color c) {
    double ch(double v) => v <= 0.03928
        ? v / 12.92
        : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
    return 0.2126 * ch(c.r) + 0.7152 * ch(c.g) + 0.0722 * ch(c.b);
  }

  final l1 = lum(a);
  final l2 = lum(b);
  final hi = math.max(l1, l2);
  final lo = math.min(l1, l2);
  return (hi + 0.05) / (lo + 0.05);
}

void main() {
  group('contrast (WCAG 2.1 AA)', () {
    test('window label on the window fill is at least 4.5:1', () {
      expect(
        ratio(AppColors.windowInk, AppColors.window),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('body text on surface is at least 4.5:1 in both themes', () {
      for (final t in [AppTheme.light(), AppTheme.dark()]) {
        expect(
          ratio(t.colorScheme.onSurface, t.colorScheme.surface),
          greaterThanOrEqualTo(4.5),
        );
      }
    });

    test('input outline against surface is at least 3:1 in both themes', () {
      for (final t in [AppTheme.light(), AppTheme.dark()]) {
        expect(
          ratio(t.colorScheme.outline, t.colorScheme.surface),
          greaterThanOrEqualTo(3),
        );
      }
    });

    test('wood panels against the light window and each theme surface', () {
      expect(ratio(AppColors.wood, AppColors.window), greaterThanOrEqualTo(3));
      expect(
        ratio(AppColors.wood, AppTheme.light().colorScheme.surface),
        greaterThanOrEqualTo(3),
      );
    });

    test('the danger outline is visible on the light theme surface', () {
      expect(
        ratio(AppColors.danger, AppTheme.light().colorScheme.surface),
        greaterThanOrEqualTo(3),
      );
    });
  });
}
