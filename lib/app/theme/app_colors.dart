import 'package:flutter/painting.dart';

/// Brand and drawing colors. Widgets take theme colors from `ColorScheme`;
/// these are only the fixed colors used by the elevation drawing and seed.
class AppColors {
  const AppColors._();

  /// Seed for both color schemes.
  static const Color seed = Color(0xFF5A3A22);

  /// Fill for 3/4" plywood panels in the drawing.
  static const Color wood = Color(0xFF5A3A22);

  /// Fill for the toe kick.
  static const Color kickWood = Color(0xFF8B6B4A);

  /// Fill for the window opening.
  static const Color window = Color(0xFFBFE3F7);

  /// Fill for the gap between the window and the shelves around it.
  static const Color gap = Color(0xFFE8C98A);

  /// Text drawn on the window fill.
  static const Color windowInk = Color(0xFF1B4F72);

  /// Outline for bays that break a limit.
  static const Color danger = Color(0xFFD32F2F);
}
