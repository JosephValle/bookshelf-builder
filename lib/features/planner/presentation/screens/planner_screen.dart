import 'package:bookshelf_builder/app/theme/layout.dart';
import 'package:bookshelf_builder/app/theme/sizes.dart';
import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_cubit.dart';
import 'package:bookshelf_builder/features/planner/presentation/cubit/planner_state.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/action_bar.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/disclaimer_footer.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/elevation_view.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/inputs_panel.dart';
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
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.notice!)));
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Shelf Planner')),
        body: BlocBuilder<PlannerCubit, PlannerState>(
          builder: (context, state) {
            final cubit = context.read<PlannerCubit>();
            final inputs = InputsPanel(
              inputs: state.inputs,
              plan: state.plan,
              onChanged: cubit.setInputs,
              onReset: cubit.reset,
            );
            final actions = ActionBar(
              onCopyCsv: cubit.copyCsv,
              onCopySummary: cubit.copySummary,
              onExportPdf: cubit.exportPdf,
            );
            return LayoutBuilder(
              builder: (context, box) {
                if (box.maxWidth >= Layout.wideBreakpoint) {
                  return Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              width: Sizes.inputsPanelWidth,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(Space.md),
                                child: inputs,
                              ),
                            ),
                            Expanded(child: ElevationView(plan: state.plan)),
                            SizedBox(
                              width: Sizes.resultsPanelWidth,
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
