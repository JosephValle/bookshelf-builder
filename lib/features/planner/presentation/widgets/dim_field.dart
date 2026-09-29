import 'package:bookshelf_builder/app/theme/sizes.dart';
import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_parser.dart';
import 'package:flutter/material.dart';

/// A labeled length input: a text field that accepts decimals or fractions
/// (`11.25`, `11 1/4`), optionally paired with a slider.
///
/// With [optional] set, an empty field reports null.
class DimField extends StatefulWidget {
  /// Creates a field.
  const DimField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.slider = true,
    this.optional = false,
    this.enabled = true,
    this.allowZero = false,
    super.key,
  });

  /// Field label.
  final String label;

  /// Current value in inches (null only for optional fields).
  final double? value;

  /// Called with each valid new value (null when an optional field is cleared).
  final ValueChanged<double?> onChanged;

  /// Slider minimum.
  final double min;

  /// Slider maximum.
  final double max;

  /// Whether to show the slider.
  final bool slider;

  /// Whether the field may be left empty.
  final bool optional;

  /// Whether the field and slider can be edited.
  final bool enabled;

  /// Whether zero is a valid value (otherwise values must be above zero).
  final bool allowZero;

  @override
  State<DimField> createState() => _DimFieldState();
}

class _DimFieldState extends State<DimField> {
  static const _formatter = InchesFormatter();
  static const _parser = InchesParser();

  late final TextEditingController _controller;
  late final FocusNode _focus;

  String _textFor(double? v) => v == null ? '' : _formatter.plain(v);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _textFor(widget.value));
    _focus = FocusNode();
  }

  @override
  void didUpdateWidget(DimField old) {
    super.didUpdateWidget(old);
    if (_focus.hasFocus) return;
    final parsed = _parser.parse(_controller.text);
    if (parsed != widget.value) {
      _controller.text = _textFor(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _typed(String text) {
    if (widget.optional && text.trim().isEmpty) {
      widget.onChanged(null);
      return;
    }
    final v = _parser.parse(text);
    if (v != null && (v > 0 || (widget.allowZero && v == 0))) {
      widget.onChanged(v);
    }
  }

  void _slid(double v) {
    final rounded = (v * 16).round() / 16;
    _controller.text = _textFor(rounded);
    widget.onChanged(rounded);
  }

  @override
  Widget build(BuildContext context) {
    final v = widget.value;
    final input = TextField(
      controller: _controller,
      focusNode: _focus,
      enabled: widget.enabled,
      onChanged: _typed,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: widget.label, suffixText: 'in'),
    );
    if (!widget.slider) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Space.xs),
        child: input,
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.xs),
      child: Row(
        children: [
          SizedBox(width: Sizes.fieldWidth, child: input),
          Expanded(
            child: Slider(
              value: (v ?? widget.min).clamp(widget.min, widget.max),
              min: widget.min,
              max: widget.max,
              label: v == null ? null : _formatter.format(v),
              semanticFormatterCallback: _formatter.format,
              onChanged: widget.enabled ? _slid : null,
            ),
          ),
        ],
      ),
    );
  }
}
