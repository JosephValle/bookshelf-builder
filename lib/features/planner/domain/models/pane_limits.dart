/// Size limits for the three resizable panes of the wide layout.
class PaneLimits {
  const PaneLimits._();

  /// Smallest width of the inputs pane.
  static const double minInputs = 260;

  /// Smallest width of the drawing pane.
  static const double minDrawing = 320;

  /// Smallest width of the results pane.
  static const double minResults = 300;

  /// Starting width of the inputs pane.
  static const double defaultInputs = 320;

  /// Starting width of the results pane.
  static const double defaultResults = 360;

  /// Pixels moved by one arrow key press on a divider.
  static const double keyStep = 16;
}
