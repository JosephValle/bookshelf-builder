import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:flutter/material.dart';

/// A row of choice chips that set a value to a preset.
class PresetChips extends StatelessWidget {
  /// Creates chips for [presets] (label to value).
  const PresetChips({
    required this.presets,
    required this.current,
    required this.onSelected,
    super.key,
  });

  /// Preset labels and values in inches.
  final Map<String, double> presets;

  /// Current value, used to mark the matching chip as selected.
  final double current;

  /// Called with the chosen value.
  final ValueChanged<double> onSelected;

  @override
  Widget build(BuildContext context) {
    const formatter = InchesFormatter();
    return Wrap(
      spacing: Space.sm,
      children: [
        for (final e in presets.entries)
          ChoiceChip(
            label: Text('${e.key} ${formatter.format(e.value)}'),
            selected: (current - e.value).abs() < 1e-9,
            onSelected: (_) => onSelected(e.value),
          ),
      ],
    );
  }
}
