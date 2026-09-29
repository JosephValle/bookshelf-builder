import 'package:bookshelf_builder/app/theme/layout.dart';
import 'package:bookshelf_builder/app/theme/sizes.dart';
import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/pane_widths.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pane_layout_calculator.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/pane_layout_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_state.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/action_bar.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/disclaimer_footer.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_view.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/inputs_panel.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/pane_divider.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/results_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The planner screen. Three columns when wide, stacked when narrow.
class PlannerScreen extends StatelessWidget {
  /// Creates the screen. It needs a [PlannerCubit] above it.
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlannerCubit, PlannerState>(
      listenWhen: (a, b) => b.notice != null && a.noticeId != b.noticeId,
      listener: (context, state) {
        final cubit = context.read<PlannerCubit>();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.notice!),
              action: state.savedPath == null
                  ? null
                  : SnackBarAction(
                      label: 'Show in Finder',
                      onPressed: cubit.revealSaved,
                    ),
            ),
          );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Shelf Planner')),
        body: BlocBuilder<PlannerCubit, PlannerState>(
          builder: (context, state) {
            final cubit = context.read<PlannerCubit>();
            final paneCubit = context.read<PaneLayoutCubit>();
            void resetAll() {
              cubit.reset();
              paneCubit.reset();
            }

            final inputs = InputsPanel(
              inputs: state.inputs,
              plan: state.plan,
              onChanged: cubit.setInputs,
              onReset: resetAll,
            );
            final actions = ActionBar(
              onCopyCsv: cubit.copyCsv,
              onCopySummary: cubit.copySummary,
              onExportPdf: cubit.exportPdf,
              onSavePdf: cubit.canSavePdf ? cubit.savePdf : null,
            );
            return LayoutBuilder(
              builder: (context, box) {
                if (box.maxWidth >= Layout.wideBreakpoint) {
                  const dividers = Sizes.paneDivider * 2;
                  final total = box.maxWidth;
                  return BlocBuilder<PaneLayoutCubit, PaneWidths>(
                    builder: (context, panes) {
                      final w = const PaneLayoutCalculator().fit(
                        panes,
                        total,
                        dividers,
                      );
                      return Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: w.inputs,
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(Space.md),
                                    child: inputs,
                                  ),
                                ),
                                PaneDivider(
                                  label: 'Resize inputs panel',
                                  onDrag: (d) =>
                                      paneCubit.dragInputs(d, total, dividers),
                                  onDragEnd: paneCubit.commit,
                                  onNudge: (dir) => paneCubit.nudgeInputs(
                                    dir,
                                    total,
                                    dividers,
                                  ),
                                ),
                                Expanded(
                                  child: ElevationView(plan: state.plan),
                                ),
                                PaneDivider(
                                  label: 'Resize results panel',
                                  onDrag: (d) =>
                                      paneCubit.dragResults(d, total, dividers),
                                  onDragEnd: paneCubit.commit,
                                  onNudge: (dir) => paneCubit.nudgeResults(
                                    dir,
                                    total,
                                    dividers,
                                  ),
                                ),
                                SizedBox(
                                  width: w.results,
                                  child: Column(
                                    children: [
                                      actions,
                                      Expanded(
                                        child: ResultsTabs(plan: state.plan),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const DisclaimerFooter(),
                        ],
                      );
                    },
                  );
                }
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Space.md),
                      child: inputs,
                    ),
                    SizedBox(
                      height: Sizes.narrowDrawingHeight,
                      child: ElevationView(plan: state.plan),
                    ),
                    actions,
                    SizedBox(
                      height: Sizes.narrowResultsHeight,
                      child: ResultsTabs(plan: state.plan),
                    ),
                    const DisclaimerFooter(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
