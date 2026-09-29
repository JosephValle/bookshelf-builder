import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/input_ranges.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/dim_field.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/preset_chips.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_heading.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/wall_inputs.dart';
import 'package:flutter/material.dart';

/// All the input controls: window, columns, bars, depth, toe kick, shelf
/// opening, edge band and the optional wall.
class InputsPanel extends StatelessWidget {
  /// Creates the panel.
  const InputsPanel({
    required this.inputs,
    required this.plan,
    required this.onChanged,
    required this.onReset,
    super.key,
  });

  /// Current inputs.
  final Inputs inputs;

  /// Plan computed from [inputs] (with columns resolved against the wall).
  final Plan plan;

  /// Called with the edited inputs.
  final ValueChanged<Inputs> onChanged;

  /// Called when the user resets to defaults.
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final fillsWall = inputs.wallW != null && inputs.fillWall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading('Window opening'),
        DimField(
          label: 'Width',
          value: inputs.windowW,
          min: InputRanges.windowWMin,
          max: InputRanges.windowWMax,
          onChanged: (v) => onChanged(inputs.copyWith(windowW: v)),
        ),
        DimField(
          label: 'Height',
          value: inputs.windowH,
          min: InputRanges.windowHMin,
          max: InputRanges.windowHMax,
          onChanged: (v) => onChanged(inputs.copyWith(windowH: v)),
        ),
        const SectionHeading('Columns and bars'),
        if (fillsWall)
          const Padding(
            padding: EdgeInsets.only(bottom: Space.sm),
            child: Text(
              'Column widths come from the wall. Turn off "Columns fill the '
              'wall width" to set them yourself.',
            ),
          ),
        DimField(
          label: 'Left column',
          enabled: !fillsWall,
          value: fillsWall ? plan.inputs.left : inputs.left,
          min: InputRanges.sectionMin,
          max: InputRanges.sectionMax,
          onChanged: (v) => onChanged(inputs.copyWith(left: v)),
        ),
        DimField(
          label: 'Right column',
          enabled: !fillsWall,
          value: fillsWall ? plan.inputs.right : inputs.right,
          min: InputRanges.sectionMin,
          max: InputRanges.sectionMax,
          onChanged: (v) => onChanged(inputs.copyWith(right: v)),
        ),
        DimField(
          label: 'Top bar',
          value: inputs.top,
          min: InputRanges.sectionMin,
          max: InputRanges.sectionMax,
          onChanged: (v) => onChanged(inputs.copyWith(top: v)),
        ),
        DimField(
          label: 'Bottom bar',
          value: inputs.bottom,
          min: InputRanges.sectionMin,
          max: InputRanges.sectionMax,
          onChanged: (v) => onChanged(inputs.copyWith(bottom: v)),
        ),
        const SectionHeading('Depth'),
        DimField(
          label: 'Total depth',
          value: inputs.depth,
          min: InputRanges.depthMin,
          max: InputRanges.depthMax,
          onChanged: (v) => onChanged(inputs.copyWith(depth: v)),
        ),
        PresetChips(
          presets: {for (final d in InputRanges.depthPresets) _depthName(d): d},
          current: inputs.depth,
          onSelected: (v) => onChanged(inputs.copyWith(depth: v)),
        ),
        const SectionHeading('Shelf openings'),
        DimField(
          label: 'Target height',
          value: inputs.targetClearH,
          min: InputRanges.clearHMin,
          max: InputRanges.clearHMax,
          onChanged: (v) => onChanged(inputs.copyWith(targetClearH: v)),
        ),
        DimField(
          label: 'Max shelf width',
          value: inputs.maxShelfWidth,
          min: InputRanges.shelfWidthMin,
          max: InputRanges.shelfWidthMax,
          onChanged: (v) => onChanged(inputs.copyWith(maxShelfWidth: v)),
        ),
        PresetChips(
          presets: InputRanges.clearHPresets,
          current: inputs.targetClearH,
          onSelected: (v) => onChanged(inputs.copyWith(targetClearH: v)),
        ),
        const SectionHeading('Options'),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('On the floor (toe kick)'),
          value: inputs.onFloor,
          onChanged: (v) => onChanged(inputs.copyWith(onFloor: v)),
        ),
        if (inputs.onFloor)
          DimField(
            label: 'Toe kick',
            value: inputs.toeKick,
            min: InputRanges.toeKickMin,
            max: InputRanges.toeKickMax,
            onChanged: (v) => onChanged(inputs.copyWith(toeKick: v)),
          ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Front edge band (36 in shelf span)'),
          value: inputs.edgeStiffener,
          onChanged: (v) => onChanged(inputs.copyWith(edgeStiffener: v)),
        ),
        const SectionHeading('Wall (optional)'),
        const Text(
          'Enter the wall size to see it in the drawing. The columns grow to fill '
          'it, and you can slide the window along the wall.',
        ),
        WallInputs(inputs: inputs, plan: plan, onChanged: onChanged),
        const SizedBox(height: Space.md),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: onReset,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset to defaults'),
          ),
        ),
      ],
    );
  }

  static String _depthName(double d) {
    if (d == 7.25) return '1x8';
    if (d == 9.25) return '1x10';
    return '1x12';
  }
}
