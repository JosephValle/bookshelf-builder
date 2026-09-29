# Architecture

Shelf Planner is a Flutter app organised by feature, with each feature split into three layers. There is one feature today, `planner`.

```
lib/
  main.dart                       loads saved state, then starts the app
  app/
    app.dart                      wires cubits to their platform implementations
    theme/                        design tokens and the light and dark themes
  features/planner/
    domain/
      models/                     immutable value objects (one class per file)
      services/                   pure logic and abstract ports
    data/
      services/                   implementations of the ports
    presentation/
      cubit/                      state holders
      screens/                    composes widgets
      widgets/                    everything drawn on screen
```

## Rules

- **One public class per file**, named after the file.
- **Domain code is pure Dart.** It never imports Flutter widgets or another layer's `presentation/`, so the whole planning engine can be tested without a UI.
- **Ports live in `domain/services/`**, their implementations in `data/`. Tests inject fakes (`test/features/planner/support/`).
- **Styling is centralised** in `lib/app/theme/`. Widgets take colors from the theme's `ColorScheme` and never hard-code paddings, radii, sizes or breakpoints.
- **Tests mirror `lib/` exactly**: `lib/a/b/c.dart` is tested by `test/a/b/c_test.dart`.

## Data flow

```
user edits a field
   -> PlannerCubit.setInputs(Inputs)
   -> PlanEngine.compute(Inputs)  ->  Plan
   -> PlannerState(inputs, plan)  ->  screen rebuilds
   -> InputsStore.save(inputs)
```

`Inputs` is immutable and compared by value, so an edit that changes nothing does not recompute or save. Every field must be listed in `Inputs.props`; a test fails if one is missing.

`PlanEngine` is a chain of small services:

| Service | Job |
|---|---|
| `Dimensions.from` | Overall ring size, panel depth, toe kick, column height, shelf limits |
| `ColumnPlanner` | Shelves and vertical dividers of a side column |
| `BarPlanner` | Dividers and tiers of the top and bottom bars |
| `PartsBuilder` | The cut list |
| `GeometryBuilder` | Every panel and bay as a rectangle, for drawing |
| `SheetEstimator` | Plywood sheet count |
| `IssueChecker` | Warnings, errors and notes |

Around the plan there are a few more services: `CostEstimator` (prices the sheets), `ToolRecommender`, `AssemblyGuideBuilder` (with `AssemblyDiagramBuilder`, `PieceIds`, `FastenerCounter` and `CleatLayout` behind it), and the `CutListCsvBuilder` and `SummaryBuilder` text exporters. The screen, the PDF and the text exports all read from the same `Plan`.

Before any of that, `Inputs.resolved` grows the columns and bars to fill the wall when a wall size is set.

## Other cubits and stores

- `PaneLayoutCubit` holds the widths of the inputs and results panes. `PaneLayoutCalculator` enforces minimum widths and turns drags into new widths.
- `InputsStore` and `PaneLayoutStore` are ports. The app uses `shared_preferences` implementations that never throw.
- `ClipboardWriter` and `PdfExporter` are ports for copying text and opening the print dialog.

## Dependencies

| Package | Used for |
|---|---|
| `flutter_bloc`, `equatable` | State management and value equality |
| `pdf`, `printing` | Building the PDF and opening the print dialog |
| `shared_preferences` | Remembering inputs and pane widths |
| `bloc_test` (dev) | Testing cubits |
