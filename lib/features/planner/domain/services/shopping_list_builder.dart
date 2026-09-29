import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/models/shopping_item.dart';
import 'package:bookshelf_builder/features/planner/domain/models/shopping_kind.dart';

/// Lists the tools and consumable supplies for a plan with their prices.
///
/// Quantities come from the plan. Prices come from
/// [PriceCatalog.supplyPrices] and are null until a listing price has been
/// recorded for that item.
class ShoppingListBuilder {
  /// Creates a builder that reads prices from [prices].
  const ShoppingListBuilder({this.prices = PriceCatalog.supplyPrices});

  /// Price of one unit by item id.
  final Map<String, double> prices;

  /// Builds the list: materials first, then essential tools, then optional
  /// tools.
  List<ShoppingItem> build(Plan plan) {
    final sheets = plan.sheets.sheets34 + plan.sheets.backSheets;
    final clamps = plan.ringW > 96 || plan.ringH > 84 ? 8 : 6;
    ShoppingItem item(
      String id,
      String name,
      ShoppingKind kind,
      int quantity,
      String unit, {
      bool essential = true,
    }) => ShoppingItem(
      id: id,
      name: name,
      kind: kind,
      quantity: quantity,
      unit: unit,
      unitPrice: prices[id],
      essential: essential,
    );
    const m = ShoppingKind.material;
    const t = ShoppingKind.tool;
    return [
      item(
        'glue',
        'Wood glue, 16 oz',
        m,
        (sheets / 4).ceil().clamp(1, 99),
        'bottle',
      ),
      item('screws-1-1-4', '1-1/4" screws', m, 1, 'box'),
      item('brads-1', '1" brad nails, 18 gauge', m, 1, 'box'),
      item('screws-structural', 'Structural screws, about 3"', m, 1, 'box'),
      item('anti-tip', 'Anti-tip straps', m, 1, 'pack'),
      if (plan.inputs.onFloor) item('shims', 'Shims', m, 1, 'pack'),
      item('sandpaper', 'Sandpaper, 150 grit', m, 1, 'pack'),
      item('saw', 'Track saw or circular saw with a guide', t, 1, 'tool'),
      item('miter-saw', 'Miter saw', t, 1, 'tool'),
      item('drill', 'Cordless drill/driver with countersink bit', t, 1, 'tool'),
      item('clamps', 'Bar or parallel clamps', t, clamps, 'clamp'),
      item('square', 'Framing square', t, 1, 'tool'),
      item('tape', 'Tape measure', t, 1, 'tool'),
      item('nailer', '18 gauge brad nailer', t, 1, 'tool'),
      item(
        'safety',
        'Safety glasses, ear protection and dust mask',
        t,
        1,
        'set',
      ),
      item('level', '4 ft level', t, 1, 'tool'),
      item('stud-finder', 'Stud finder', t, 1, 'tool'),
      item('pocket-jig', 'Pocket hole jig', t, 1, 'tool', essential: false),
      item('sander', 'Random orbit sander', t, 1, 'tool', essential: false),
      item('roundover', 'Roundover router bit', t, 1, 'bit', essential: false),
    ];
  }
}
