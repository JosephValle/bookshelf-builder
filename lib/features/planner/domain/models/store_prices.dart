import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_prices.freezed.dart';

/// Per-unit prices for one store. A null price means it has not been found.
@freezed
abstract class StorePrices with _$StorePrices {
  /// Creates a price list.
  const factory StorePrices({
    /// Store name, for example "Lowe's".
    required String store,

    /// Price of one 4x8 sheet of 3/4" sanded plywood.
    double? sheet34,

    /// Price of one 4x8 sheet of 1/4" sanded plywood.
    double? sheet14,

    /// Price of solid edge band per linear foot.
    double? edgeBandPerFoot,

    /// Product the 3/4" price refers to.
    @Default('3/4" sanded plywood, 4x8') String sheet34Label,

    /// Product the 1/4" price refers to.
    @Default('1/4" sanded plywood, 4x8') String sheet14Label,
  }) = _StorePrices;
}
