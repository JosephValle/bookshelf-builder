import 'package:equatable/equatable.dart';

/// Per-unit prices for one store. A null price means it has not been found.
class StorePrices extends Equatable {
  /// Creates a price list.
  const StorePrices({
    required this.store,
    this.sheet34,
    this.sheet14,
    this.edgeBandPerFoot,
    this.sheet34Label = '3/4" sanded plywood, 4x8',
    this.sheet14Label = '1/4" sanded plywood, 4x8',
  });

  /// Store name, for example "Lowe's".
  final String store;

  /// Price of one 4x8 sheet of 3/4" sanded plywood.
  final double? sheet34;

  /// Price of one 4x8 sheet of 1/4" sanded plywood.
  final double? sheet14;

  /// Price of solid edge band per linear foot.
  final double? edgeBandPerFoot;

  /// Product the 3/4" price refers to.
  final String sheet34Label;

  /// Product the 1/4" price refers to.
  final String sheet14Label;

  @override
  List<Object?> get props => [
    store,
    sheet34,
    sheet14,
    edgeBandPerFoot,
    sheet34Label,
    sheet14Label,
  ];
}
