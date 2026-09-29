/// Fixed sizes in logical pixels.
class Sizes {
  const Sizes._();

  /// Width of the draggable divider between panes.
  static const double paneDivider = 12;

  /// Height of the drawing in the narrow layout.
  static const double narrowDrawingHeight = 420;

  /// Height of the results tabs in the narrow layout.
  static const double narrowResultsHeight = 480;

  /// Padding around the drawing that holds the dimension lines.
  static const double drawingPadding = 56;

  /// Distance from the ring to its dimension lines.
  static const double dimOffset = 22;

  /// Half length of a dimension line end tick.
  static const double dimTick = 5;

  /// Smallest bay width (px) that still gets a size label.
  static const double minLabelBayW = 46;

  /// Smallest bay height (px) that still gets a size label.
  static const double minLabelBayH = 24;

  /// Width of a text field next to its slider.
  static const double fieldWidth = 128;
}
