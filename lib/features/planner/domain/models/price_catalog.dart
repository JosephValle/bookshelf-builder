import 'package:bookshelf_builder/features/planner/domain/models/store_prices.dart';

/// Hardcoded reference prices for one ZIP code.
///
/// These are a snapshot, not live prices. Update [updated] and the values
/// together whenever they are refreshed.
class PriceCatalog {
  const PriceCatalog._();

  /// ZIP code the prices are meant for.
  static const String zip = '33713';

  /// Date the prices were last updated (year-month-day).
  static const String updated = '2026-09-29';

  /// Estimated combined sales tax rate for the ZIP (Pinellas County, FL:
  /// 6 percent state plus 1 percent county surtax).
  static const double salesTaxRate = 0.07;

  /// What the numbers are and how far to trust them.
  static const String note =
      'Reference prices for ZIP 33713, last updated 2026-09-29, from '
      'lowes.com listings (3/4" x 4x8 sanded poplar plywood and 1/4" x 4x8 '
      'sanded Douglas fir plywood). The store was not confirmed for the ZIP. '
      'Solid edge band is priced as strips ripped from the 3/4" sheet. Home '
      'Depot prices could not be retrieved because the site blocks automated '
      'lookups, so only Lowe\'s is shown. A 7 percent sales tax is added '
      '(Pinellas County, FL). Prices change often and vary by '
      'store, species and grade. Check the shelf tag before you buy.';

  /// Lowe's listing prices.
  static const StorePrices lowes = StorePrices(
    store: "Lowe's",
    sheet34: 69.85,
    sheet14: 35.01,
    sheet34Label: '3/4" sanded poplar plywood, 4x8',
    sheet14Label: '1/4" sanded Douglas fir plywood, 4x8',
  );

  /// Price of one unit of each tool and supply, by item id (see
  /// `ShoppingListBuilder`), copied from a retailer listing.
  ///
  /// An id with no entry has no recorded price and shows as unknown. Add an
  /// entry only from a listing you have seen, and update [updated] with it.
  static const Map<String, double> supplyPrices = {
    // Harbor Freight listings, read 2026-09-29.
    // BAUER 14 Amp, 7-1/4 in. Circular Saw (blade and guide not included).
    'saw': 44.99,
    // BAUER 20V Cordless, 1/2 in. Drill/Driver Kit, 2 Ah battery and charger.
    'drill': 59.99,
    // PITTSBURGH 24 in. Quick-Release Bar Clamp, price for one.
    'clamps': 6.99,
    // BAUER 20V Cordless 18 Gauge Brad Nailer, tool only (battery separate).
    'nailer': 119.99,
    // PITTSBURGH 48 in. Box Frame Level.
    'level': 15.99,
    // FRANKLIN SENSORS ProSensor M10 Stud Finder.
    'stud-finder': 16.99,
  };

  /// Where the tool and supply prices came from and what is missing.
  static const String supplyNote =
      'Tool prices are Harbor Freight listings read on 2026-09-29: circular '
      'saw (blade and guide extra), 20V drill kit, 24 in. bar clamps, 20V '
      'brad nailer (tool only, so it needs a battery such as the one in the '
      'drill kit), 48 in. level and stud finder. Items marked unknown have no '
      'price yet because Lowe\'s and Home Depot block automated lookups, and '
      'Harbor Freight refused further requests. They are left out of the '
      'total. Check the shelf tag before you buy.';

  /// Every store shown in the app. Every price in every entry is filled in.
  static const List<StorePrices> stores = [lowes];
}
