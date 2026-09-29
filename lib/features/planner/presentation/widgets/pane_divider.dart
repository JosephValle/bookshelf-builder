import 'package:bookshelf_builder/app/theme/sizes.dart';
import 'package:bookshelf_builder/app/theme/strokes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A draggable, keyboard operable vertical divider between two panes.
///
/// Dragging reports horizontal pixel deltas. The left and right arrow keys
/// report one step at a time when the divider has focus.
class PaneDivider extends StatefulWidget {
  /// Creates a divider named [label] for assistive technology.
  const PaneDivider({
    required this.label,
    required this.onDrag,
    required this.onDragEnd,
    required this.onNudge,
    super.key,
  });

  /// Accessible name, for example "Resize inputs panel".
  final String label;

  /// Called with the horizontal movement while dragging.
  final ValueChanged<double> onDrag;

  /// Called when a drag finishes.
  final VoidCallback onDragEnd;

  /// Called with -1 or 1 when an arrow key is pressed.
  final ValueChanged<int> onNudge;

  @override
  State<PaneDivider> createState() => _PaneDividerState();
}

class _PaneDividerState extends State<PaneDivider> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: widget.label,
      container: true,
      child: Focus(
        onFocusChange: (f) => setState(() => _active = f),
        onKeyEvent: (node, event) {
          if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
            return KeyEventResult.ignored;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            widget.onNudge(-1);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            widget.onNudge(1);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragUpdate: (d) => widget.onDrag(d.delta.dx),
            onHorizontalDragEnd: (_) => widget.onDragEnd(),
            child: SizedBox(
              width: Sizes.paneDivider,
              child: Center(
                child: Container(
                  width: _active ? Strokes.dividerActive : Strokes.divider,
                  color: _active ? scheme.primary : scheme.outline,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
