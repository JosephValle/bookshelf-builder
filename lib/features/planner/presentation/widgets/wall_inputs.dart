import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/input_ranges.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/dim_field.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_heading.dart';
import 'package:flutter/material.dart';

/// Optional wall size, whether the columns fill the wall, and where the
/// window sits along it.
class WallInputs extends StatelessWidget {
  /// Creates the wall fields. [plan] is the resolved plan, used to show the
  /// column widths the wall produces.
  const WallInputs({
    required this.inputs,
    required this.plan,
    required this.onChanged,
    super.key,
  });

  /// Current inputs.
  final Inputs inputs;

  /// Plan computed from [inputs].
  final Plan plan;

  /// Called with the edited inputs.
  final ValueChanged<Inputs> onChanged;

  @override
  Widget build(BuildContext context) {
    const f = InchesFormatter();
    final wallW = inputs.wallW;
    final position = inputs.windowLeftOnWall;
    final minX = inputs.wallMarginLeft + inputs.insetLeft;
    final maxX =
        minX +
        ((inputs.usableWallW ?? 0.0) - inputs.openW).clamp(
          1.0,
          double.infinity,
        );
    final minY = inputs.insetBottom;
    final maxY =
        minY +
        ((inputs.usableWallH ?? 0.0) - inputs.openH).clamp(
          1.0,
          double.infinity,
        );
    final columns =
        'Left column ${f.format(plan.inputs.left)}, right column ${f.format(plan.inputs.right)}';
    final bars =
        'Top bar ${f.format(plan.inputs.top)}, bottom bar ${f.format(plan.inputs.bottom)}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Concrete or masonry wall'),
          subtitle: const Text('Changes how the cleat is fastened'),
          value: inputs.concreteWall,
          onChanged: (v) => onChanged(inputs.copyWith(concreteWall: v)),
        ),
        if (!inputs.concreteWall)
          DimField(
            label: 'Stud spacing (on center)',
            value: inputs.studSpacing,
            min: InputRanges.studSpacingMin,
            max: InputRanges.studSpacingMax,
            onChanged: (v) => onChanged(inputs.copyWith(studSpacing: v)),
          ),
        DimField(
          label: 'Wall width',
          value: inputs.wallW,
          slider: false,
          onCleared: () => onChanged(inputs.copyWith(wallW: null)),
          onChanged: (v) => onChanged(inputs.copyWith(wallW: v)),
        ),
        DimField(
          label: 'Wall height',
          value: inputs.wallH,
          slider: false,
          onCleared: () => onChanged(inputs.copyWith(wallH: null)),
          onChanged: (v) => onChanged(inputs.copyWith(wallH: v)),
        ),
        if (wallW != null || inputs.wallH != null) ...[
          const SectionHeading('Keep clear of'),
          if (wallW != null) ...[
            DimField(
              label: 'Left margin',
              value: inputs.wallMarginLeft,
              min: InputRanges.marginMin,
              max: InputRanges.marginMax,
              allowZero: true,
              onChanged: (v) => onChanged(inputs.copyWith(wallMarginLeft: v)),
            ),
            DimField(
              label: 'Right margin',
              value: inputs.wallMarginRight,
              min: InputRanges.marginMin,
              max: InputRanges.marginMax,
              allowZero: true,
              onChanged: (v) => onChanged(inputs.copyWith(wallMarginRight: v)),
            ),
          ],
          if (inputs.wallH != null)
            DimField(
              label: 'Top margin',
              value: inputs.wallMarginTop,
              min: InputRanges.marginMin,
              max: InputRanges.marginMax,
              allowZero: true,
              onChanged: (v) => onChanged(inputs.copyWith(wallMarginTop: v)),
            ),
        ],
        if (wallW != null || inputs.wallH != null) ...[
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Fill the wall up to the margins'),
            value: inputs.fillWall,
            onChanged: (v) => onChanged(inputs.copyWith(fillWall: v)),
          ),
          if (wallW != null)
            DimField(
              label: 'Window from wall left',
              value: position,
              min: minX,
              max: maxX,
              allowZero: true,
              onChanged: (v) =>
                  onChanged(inputs.copyWith(windowFromWallLeft: v)),
            ),
          if (inputs.wallH != null)
            DimField(
              label: 'Window from floor',
              value: inputs.windowBottomOnWall,
              min: minY,
              max: maxY,
              allowZero: true,
              onChanged: (v) => onChanged(inputs.copyWith(windowFromFloor: v)),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => onChanged(
                inputs.copyWith(
                  windowFromWallLeft: null,
                  windowFromFloor: null,
                ),
              ),
              child: const Text('Center window on wall'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: Space.sm),
            child: Text(
              [
                if (wallW != null) columns,
                if (inputs.wallH != null) bars,
              ].join('\n'),
            ),
          ),
        ],
      ],
    );
  }
}
