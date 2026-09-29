# Shelf Planner

Plan a built-in bookshelf that wraps around a window, from a Flutter app that runs on the web and on macOS.

You enter the window size and how much wall you have. Shelf Planner draws the unit to scale, works out the structure, and gives you everything you need to buy and build it:

- A to-scale front elevation with every panel at its true plywood thickness
- Automatic vertical dividers and shelves sized so no shelf spans too far
- A cut list based on standard 4x8 sheets of 3/4" and 1/4" plywood, with an id for every piece (`A1`, `B3`)
- A sheet count, a recommended tools list, and a cost estimate with subtotal, sales tax and total
- Live warnings when something is too narrow, too wide or too tall
- A printable PDF with the drawing, cut list, materials, estimated cost, recommended tools, a flat pack style assembly guide with a picture for every join, warnings and wall attachment notes

> These limits are rules of thumb, not engineering certification. Verify them against your actual book load before you build.

## What it plans

The unit is a rectangular ring (an "O") around a window: two side columns, a bar above the window and a bar below it.

```
+--------------------------------------------+  top panel
|              TOP BAR (dividers)            |
+-----------+------------------+-------------+  head panel
|           |                  |             |
|   LEFT    |      WINDOW      |    RIGHT    |
|  COLUMN   |  (+ trim + gap)  |   COLUMN    |
|           |                  |             |
+-----------+------------------+-------------+  sill panel
|           |   BOTTOM BAR     |             |
+-----------+------------------+-------------+  bottom panel
|  toe kick (optional)                       |
+--------------------------------------------+
```

Inputs you can change:

| Area | What you can set |
|---|---|
| Window | Width and height, optional trim and gap on each of the four sides |
| Columns and bars | Left, right, top and bottom sizes |
| Shelves | Target opening height (paperback, hardcover, oversize presets) and the widest shelf you want |
| Depth | 1x8, 1x10 or 1x12 presets, or any depth |
| Base | On the floor with a toe kick, or floating |
| Edge band | A solid front edge that allows longer shelf spans |
| Wall (optional) | Wall width and height, margins to keep clear on the left, right and top, and where the window sits along the wall and above the floor. The columns and bars grow to fill the space between the margins |

Lengths accept decimals or fractions (`11.25` or `11 1/4`) and are shown to the nearest 1/16".

## Features worth knowing about

- **Plywood thickness is accounted for everywhere.** 3/4" sanded plywood is 23/32" thick and the 1/4" back is 7/32". Tests check that the panels, bays, opening and toe kick tile the ring exactly.
- **Structure over the window.** The bar above the window is a glued box beam with a solid anchor cleat inside it, so wall anchors bite solid plywood.
- **Hangs on a French cleat.** The cut list, materials and cost include both halves of a 3/4" plywood French cleat (wall side and unit side), and the assembly guide walks through cutting, bevelling and hanging them.
- **Flat pack style instructions.** Every piece has an id (`A1`, `B3`); identical pieces share a letter. The guide has one small step and one 2D picture per join, such as "attach shelf D3 to B1", with the screw count, the distance of each screw from the edges, and the pieces and hardware each step uses.
- **Tools and hardware in every step.** Each step lists the tools it uses and what each is for (the drill and its bit, the saw tilted to 45 degrees, the brad nailer), and the screws, nails and glue it needs with counts.
- **Tick boxes and checkpoints.** Every step has a tick box, and after each stage a checkpoint shows what the build should look like and lists what to check.
- **Concrete or stud wall.** Switch the wall type and the cleat steps, tools, shopping list and screw counts change. Stud spacing is an input.
- **Piece map.** The last page repeats the main drawing with the id of every piece written on it.
- **Written for beginners.** The guide explains the terms and safety basics, gives shelf mark heights and divider positions, and lists a check after each stage.
- **Fits your wall.** Give it a wall size and margins and the unit stretches to fill the space, with the window where you want it.
- **Recommended tools.** The list adapts to your plan: cutting tools scale with the number of sheets, and edge band, floor leveling, wall work and very tall units add their own items.
- **Remembers your work.** Inputs and the pane layout are saved and restored on refresh. Reset returns everything to the defaults.
- **Resizable panes.** Drag the dividers between inputs, drawing and results (arrow keys work too). Each pane has a minimum width and the layout adapts when the window changes.
- **Cost estimate.** Uses dated reference prices for ZIP 33713, currently from Lowe's listings, plus an estimated 7% sales tax. See [docs/DESIGN.md](docs/DESIGN.md#cost-estimate) for exactly what the numbers are.

## Run it

You need the [Flutter SDK](https://docs.flutter.dev/get-started/install).

```
flutter pub get
flutter run -d chrome
flutter run -d macos
```

### Troubleshooting: the web canvas flashes blank

On some machines the web build flashes blank and recovers, and the browser console fills with CanvasKit shader errors (`canvaskit.js` printing a fragment shader followed by `Errors:`). It is a WebGL problem in the browser or graphics driver, not in the app, and the blinking text cursor makes it show up because it repaints every half second. Try one of these:

- Turn on hardware acceleration in the browser, or update the graphics driver.
- Run with software rendering:

```
flutter run -d chrome --dart-define=FLUTTER_WEB_CANVASKIT_FORCE_CPU_ONLY=true
```

- Or start Chrome with its GPU disabled:

```
flutter run -d chrome --web-browser-flag="--disable-gpu"
```

Software rendering is a little slower but is enough for this app.

## Generated code

The value models in `lib/features/planner/domain/models/` are written with [freezed](https://pub.dev/packages/freezed), which generates `copyWith`, `==`, `hashCode` and `toString`. `Inputs` also uses [json_serializable](https://pub.dev/packages/json_serializable) for its saved JSON. The generated `*.freezed.dart` and `*.g.dart` files are committed, so a fresh clone runs without any extra step.

After you add or change a field on a model, regenerate them:

```
dart run build_runner build
```

While you are editing models, `dart run build_runner watch` regenerates on every save. Never edit a generated file by hand: change the model and run the generator again.

To add a field to `Inputs`, add it to the factory constructor with an `@Default(...)` (or make it nullable), run the generator, and add it to `InputsCodec` only if it needs an unusual validation rule. The saved JSON and equality follow from the constructor automatically.

## Test it

```
flutter test
```

Before committing, the project keeps a clean run of:

```
dart run build_runner build
dart fix --apply
dart format .
flutter analyze
flutter test
```

## Project layout

The code follows a feature-first layout with three layers:

```
lib/
  app/                     app widget and design tokens (colors, spacing, sizes)
  features/planner/
    domain/                pure Dart: models (freezed) and services (no Flutter widgets)
    data/                  clipboard, PDF and saved-state implementations
    presentation/          cubits, screens and widgets
test/                      mirrors lib/ one to one
```

Read [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for how the layers fit together and [docs/DESIGN.md](docs/DESIGN.md) for the planning rules, formulas and constants.

## Limits and assumptions

- Structural limits (30" shelf span, 36" with an edge band, 24" box beam spacing, 60" maximum window span) are rules of thumb for 3/4" plywood under books.
- Home Depot in-store panel cuts are limited and priced per cut. Stock sizes and availability vary by store.
- Prices are a snapshot and will drift. Check the shelf tag before you buy.
- The sheet count is an estimate. It packs parts into ripped strips and does not account for grain direction or defects.

## Contributing

Issues and pull requests are welcome. Please keep the clean run above passing, add tests for new behavior next to the file they cover, and keep the disclaimer about rules of thumb intact.

## License

No license has been chosen yet. Until one is added, all rights are reserved by the author.
