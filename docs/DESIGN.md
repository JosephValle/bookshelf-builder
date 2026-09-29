# Design notes

The rules, formulas and constants behind the plan. All values are inches. These are rules of thumb, not engineering certification.

## Constants

| Name | Value | Meaning |
|---|---|---|
| `t` | 0.71875 | Actual thickness of 3/4" sanded plywood (23/32") |
| `backT` | 0.21875 | Actual thickness of 1/4" plywood (7/32") |
| `sheetW` x `sheetL` | 48 x 96 | Sheet size |
| `kerf` | 0.125 | Saw kerf |
| `maxShelfSpan` | 30 | Longest clear span of a bare-edge 3/4" shelf under books |
| `maxShelfSpanStiffened` | 36 | Same with a solid front edge band |
| `boxBeamMaxWebSpacing` | 24 | Longest clear spacing of dividers in a bar over the window |
| `maxWindowSpan` | 60 | Widest opening the bars can span without added support |
| `minClearW` / `minClearH` | 8 / 7.5 | Smallest bay |
| `minOuterSection` | 9.4375 | `minClearW + 2t`, the smallest column width or bar height |
| `anchorCleatW` | 3.5 | Height of the solid anchor cleat |

## Derived values

- `ringW = left + openW + right`, `ringH = top + openH + bottom`
- `openW = windowW + trimLeft + trimRight + gapLeft + gapRight` (and likewise for `openH`)
- `depthPanel = depth - backT`, the depth of every 3/4" panel
- `kick = onFloor ? toeKick : 0`
- `sideH = ringH - kick - 2t`, the length of the column panels
- `shelfWidth = min(maxShelfWidth, spanLimit)`, the widest bay the planner allows

## Shelves and dividers

For a column with target opening height `h`:

- shelves `n = max(0, ceil((sideH - h) / (h + t)))`
- clear opening height `(sideH - n * t) / (n + 1)`

For a horizontal run `L` and widest allowed bay `S`:

- dividers `d = max(0, ceil((L - S) / (S + t)))`
- clear bay width `(L - d * t) / (d + 1)`

Stack height does not change a shelf's allowed width: each shelf is supported at both ends, so its sag depends on its own span, depth, thickness and load.

## The bars

The bar over the window has nothing under it, so it is built as a glued box beam. The top panel and head panel are the skins, the vertical dividers are the webs, and the back panel is glued and nailed. A solid 3/4" plywood anchor cleat (3-1/2" tall) runs the full width against the back, with each divider notched to sit flush against it, so wall anchors bite solid plywood.

The bottom bar rests on the toe kick and floor when the unit is on the floor, so its dividers carry load down and it uses the shelf span limit. Off the floor it is built like the top bar and needs a support plan.

## Wall mounting

The unit hangs on a 3/4" plywood French cleat: two matching strips ripped with a 45 degree bevel. The wall half is screwed into the studs and the unit half is glued and screwed to the back of the unit, through the 1/4" back into a shelf or panel edge. Each half is `anchorCleatW` (3-1/2") wide and runs as one top row and one mid-height row on each column, so the cut list holds one strip of each half with length `2 * (left + right)`. Once hung, the unit stands about 3/4" off the wall. The bar over the window is also anchored through its solid anchor cleat, with 3/4" scrap spacers behind the screws.

## Piece ids and the assembly guide

Every part gets a letter, and every physical piece gets a number within that letter: two identical 76" panels are `A1` and `A2`. Parts share a letter when their material, length and width match to 1/1000 inch, even if their names differ (the head panel and the sill panel are both `C`). `I` and `O` are skipped. The letters run A to Z, then AA, AB and so on. Ids are assigned by `PartLabeler` in cut list order, so they are stable for a given plan.

The guide is written like flat pack instructions: one small step per join, each with a picture. Repeated joins are written out in full (six shelves are six steps), because a beginner should never have to guess where a piece goes. Each step names the exact pieces (`attach shelf D3 to B1`), gives the position from the bottom or left end, the screw count and where each screw sits.

Fastener rules live in `Fasteners`: screws go 1" in from the front and back edges of a panel, with a third in the middle when the panel is deeper than 9". Brads go 3/8" from the edge and 6" apart. Cleat screws are 1" from the ends and 6" apart, and wall screws are two per stud, 1" from the top and bottom edges. `FastenerCounter` turns those rules into the counts shown in the shopping list line of the guide.

Build order: the columns are built flat, each bar is built as a unit with its long top or bottom panel, and the ring is then assembled lying on its back (every panel standing on its back edge). The edge band and toe kick go on with the unit still on its back, then the unit is flipped onto its front for the four back panels and the unit half of the cleat.

Pictures are `AssemblyDiagram`s: flat, not to scale, with piece ids on the shapes, arrows for movement, screw marks and dimension lines. They are built in the domain layer by `AssemblyDiagramBuilder` and drawn into the PDF by `PdfDiagram`. A test checks every point of every picture stays inside its canvas.

## Trim and gap

Around the window the layers are, from the window outward: trim (casing), then a clearance gap, then the shelves. Each layer can be set per side. The framed opening the ring surrounds is the window plus both layers.

## Fitting a wall

With a wall width and height set, and "Fill the wall up to the margins" on:

- the columns grow so the ring runs from the left margin to the right margin
- the bars grow so the ring runs from the floor to the top margin
- the window sits where you put it (default centered between the margins), never inside a margin

With fill off, the ring keeps its own size and the checks report whether it fits.

## Sheets

- `stripsPerSheet = floor((sheetW + kerf) / (depthPanel + kerf))`
- 3/4" parts are packed into strips of `depthPanel` width, first fit decreasing, with a kerf after each part
- the toe kick, anchor cleats and both French cleat halves are narrower, and share leftover width or cost extra strips
- parts longer than a sheet are left out and raise a warning
- 1/4" backs: `ceil(total area / (sheetW * sheetL * 0.85))`, approximate

## Cost estimate

The estimate multiplies sheet counts by hardcoded reference prices for ZIP 33713, last updated 2026-09-29. The file to update is `lib/features/planner/domain/models/price_catalog.dart`; change the date and the prices together.

- Lowe's prices come from lowes.com listings: 3/4" x 4x8 sanded poplar plywood at $69.85 and 1/4" x 4x8 sanded Douglas fir plywood at $35.01. The store was not confirmed for the ZIP.
- Home Depot prices could not be retrieved, so it is not shown.
- Edge band is priced as 3/4" strips ripped from a 3/4" sheet.
- The estimate shows a subtotal, an estimated 7% sales tax (Pinellas County, FL) and a total.

## Recommended tools

`ToolRecommender` builds the list from the plan. Cutting tools are described in terms of the plan's sheet and rip counts, the clamp count grows for large rings, a helper is suggested above 84" tall, shims appear only on the floor, and edge band adds an optional strip tool. Essential items are listed before optional ones.

## Saved state

Inputs and pane widths are saved as JSON in `shared_preferences` (browser local storage on the web). A damaged or older save falls back to defaults field by field. Reset clears both.
