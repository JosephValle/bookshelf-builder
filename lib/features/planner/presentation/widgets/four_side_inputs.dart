import 'package:bookshelf_builder/features/planner/domain/models/sides.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/dim_field.dart';
import 'package:flutter/material.dart';

/// Inputs for four lengths around a rectangle, collapsed into a vertical and
/// a horizontal value until the user chooses to set all four separately.
///
/// "Vertical" means the left and right sides (like the side casings of a
/// window); "horizontal" means the top and bottom sides (the head and sill).
class FourSideInputs extends StatefulWidget {
  /// Creates the inputs.
  const FourSideInputs({
    required this.sides,
    required this.min,
    required this.max,
    required this.onChanged,
    this.name = '',
    super.key,
  });

  /// Current values.
  final Sides sides;

  /// Smallest slider value.
  final double min;

  /// Largest slider value.
  final double max;

  /// Called with the edited sides.
  final ValueChanged<Sides> onChanged;

  /// Word added to the field labels, for example "trim".
  final String name;

  @override
  State<FourSideInputs> createState() => _FourSideInputsState();
}

class _FourSideInputsState extends State<FourSideInputs> {
  late bool _custom = !widget.sides.isPaired;

  String _label(String base) =>
      widget.name.isEmpty ? base : '$base ${widget.name}';

  Widget _field(String label, double value, Sides Function(double v) apply) {
    return DimField(
      label: label,
      value: value,
      min: widget.min,
      max: widget.max,
      allowZero: true,
      onChanged: (v) => widget.onChanged(apply(v)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.sides;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Set all four sides separately'),
          value: _custom,
          onChanged: (v) {
            setState(() => _custom = v);
            if (!v) {
              widget.onChanged(
                Sides(top: s.top, bottom: s.top, left: s.left, right: s.left),
              );
            }
          },
        ),
        if (_custom) ...[
          _field(_label('Top'), s.top, (v) => s.copyWith(top: v)),
          _field(_label('Bottom'), s.bottom, (v) => s.copyWith(bottom: v)),
          _field(_label('Left'), s.left, (v) => s.copyWith(left: v)),
          _field(_label('Right'), s.right, (v) => s.copyWith(right: v)),
        ] else ...[
          _field(
            _label('Horizontal'),
            s.top,
            (v) => s.copyWith(top: v, bottom: v),
          ),
          _field(
            _label('Vertical'),
            s.left,
            (v) => s.copyWith(left: v, right: v),
          ),
        ],
      ],
    );
  }
}
