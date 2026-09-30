import 'package:bookshelf_builder/features/planner/domain/models/fasteners.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/models/shopping_item.dart';
import 'package:bookshelf_builder/features/planner/domain/models/shopping_kind.dart';
import 'package:bookshelf_builder/features/planner/domain/services/fastener_counter.dart';

/// Lists the tools and consumable supplies for a plan with their prices.
///
/// Quantities come from the plan; fasteners are counted in boxes of a standard
/// size, and their names carry the exact count needed. Prices come from
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
    const counter = FastenerCounter();
    // Boxes needed for [n] fasteners in boxes of [size], with 10 percent
    // spares. The box sizes are standard round numbers, not a retailer's.
    int boxes(int n, int size) => (n * 1.1 / size).ceil().clamp(1, 99);
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
      ...[
        ('screws-1-1-4', Fasteners.boxScrew, counter.boxScrews(plan), 100),
        (
          'screws-unit-cleat',
          Fasteners.unitCleatScrew,
          counter.unitCleatScrews(plan),
          100,
        ),
        ('brads-1', '1" brad nails, 18 gauge', counter.backBrads(plan), 1000),
        if (plan.inputs.concreteWall)
          (
            'screws-concrete',
            Fasteners.concreteScrew,
            counter.wallCleatScrews(plan),
            25,
          )
        else
          (
            'screws-structural',
            Fasteners.studScrew,
            counter.wallCleatScrews(plan),
            50,
          ),
      ].map(
        (f) => item(
          f.$1,
          '${f.$2}, box of ${f.$4} (need about ${f.$3})',
          m,
          boxes(f.$3, f.$4),
          'box',
        ),
      ),
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
      if (plan.inputs.concreteWall) ...[
        item('hammer-drill', 'Hammer drill with masonry bits', t, 1, 'tool'),
        item('blowout', 'Blow-out bulb or vacuum', t, 1, 'tool'),
      ] else
        item('stud-finder', 'Stud finder', t, 1, 'tool'),
      item('pocket-jig', 'Pocket hole jig', t, 1, 'tool', essential: false),
      item('sander', 'Random orbit sander', t, 1, 'tool', essential: false),
      item('roundover', 'Roundover router bit', t, 1, 'bit', essential: false),
    ];
  }
}
