/// Slider bounds and preset values for the input controls.
class InputRanges {
  const InputRanges._();

  /// Window width slider range.
  static const double windowWMin = 12;
  static const double windowWMax = 120;

  /// Window height slider range.
  static const double windowHMin = 12;
  static const double windowHMax = 96;

  /// Column width and bar height slider range.
  static const double sectionMin = 8;
  static const double sectionMax = 40;

  /// Depth slider range.
  static const double depthMin = 6;
  static const double depthMax = 16;

  /// Toe kick slider range.
  static const double toeKickMin = 2;
  static const double toeKickMax = 6;

  /// Target clear shelf height slider range.
  static const double clearHMin = 6;
  static const double clearHMax = 20;

  /// Depth presets: 1x8, 1x10 and 1x12 boards plus the back panel.
  static const List<double> depthPresets = [7.25, 9.25, 11.25];

  /// Shelf opening presets by book type.
  static const Map<String, double> clearHPresets = {
    'Paperback': 8,
    'Hardcover': 10,
    'Oversize': 13,
  };
}
