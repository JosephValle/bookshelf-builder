import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/dim_field.dart';
import 'package:flutter/material.dart';

/// Optional wall size and ring position fields used for fit checks.
class WallInputs extends StatelessWidget {
  /// Creates the wall fields.
  const WallInputs({required this.inputs, required this.onChanged, super.key});

  /// Current inputs.
  final Inputs inputs;

  /// Called with the edited inputs.
  final ValueChanged<Inputs> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DimField(
          label: 'Wall width',
          value: inputs.wallW,
          slider: false,
          optional: true,
          onChanged: (v) => onChanged(inputs.copyWith(wallW: () => v)),
        ),
        DimField(
          label: 'Wall height',
          value: inputs.wallH,
          slider: false,
          optional: true,
          onChanged: (v) => onChanged(inputs.copyWith(wallH: () => v)),
        ),
        DimField(
          label: 'Ring offset from left',
          value: inputs.ringOffsetFromLeft,
          slider: false,
          optional: true,
          onChanged: (v) =>
              onChanged(inputs.copyWith(ringOffsetFromLeft: () => v)),
        ),
      ],
    );
  }
}
