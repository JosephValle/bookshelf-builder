import 'package:bookshelf_builder/features/planner/domain/models/cost_estimate.dart';
import 'package:bookshelf_builder/features/planner/domain/models/cost_line.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/models/store_prices.dart';

/// Prices the sheets and edge band of a plan at one store.
class CostEstimator {
  /// Creates an estimator.
  const CostEstimator({this.taxRate = PriceCatalog.salesTaxRate});

  /// Sales tax rate applied to the subtotal.
  final double taxRate;

  /// Estimates the cost of [plan] using [prices].
  ///
  /// There is one line per panel type (3/4" and 1/4" sheets) and one for edge
  /// band when the plan uses it. A line whose price is unknown stays in the
  /// estimate with a null price so the app can say what is missing.
  CostEstimate estimate(Plan plan, StorePrices prices) {
    final lines = <CostLine>[
      CostLine(
        label: prices.sheet34Label,
        quantity: plan.sheets.sheets34.toDouble(),
        unit: 'sheet',
        unitPrice: prices.sheet34,
      ),
      CostLine(
        label: prices.sheet14Label,
        quantity: plan.sheets.backSheets.toDouble(),
        unit: 'sheet',
        unitPrice: prices.sheet14,
      ),
      if (plan.edgeBandInches > 0)
        CostLine(
          label: prices.edgeBandPerFoot == null
              ? 'Edge band ripped from 3/4" plywood'
              : 'Solid edge band',
          quantity: (plan.edgeBandInches / 12).ceilToDouble(),
          unit: 'ft',
          unitPrice: prices.edgeBandPerFoot ?? ripCostPerFoot(prices.sheet34),
        ),
    ];
    return CostEstimate(prices: prices, lines: lines, taxRate: taxRate);
  }

  /// Cost per linear foot of 3/4" wide edge band ripped from a 4x8 sheet that
  /// costs [sheetPrice], or null when the sheet price is unknown.
  ///
  /// A sheet yields `floor((48 + kerf) / (3/4 + kerf))` strips of 8 feet.
  double? ripCostPerFoot(double? sheetPrice) {
    if (sheetPrice == null) return null;
    final strips = ((Limits.sheetW + Limits.kerf) / (0.75 + Limits.kerf))
        .floor();
    return sheetPrice / (strips * Limits.sheetL / 12);
  }
}
