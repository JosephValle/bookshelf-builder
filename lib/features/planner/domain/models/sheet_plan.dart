import 'package:equatable/equatable.dart';

/// Plywood sheet estimate.
class SheetPlan extends Equatable {
  /// Creates a sheet estimate.
  const SheetPlan({
    required this.stripsPerSheet,
    required this.neededStrips,
    required this.sheets34,
    required this.backArea,
    required this.backSheets,
  });

  /// Strips of panel depth that one 4x8 sheet yields.
  final int stripsPerSheet;

  /// Strips of full sheet length needed for all 3/4" parts.
  final int neededStrips;

  /// Number of 3/4" sheets to buy.
  final int sheets34;

  /// Total 1/4" back panel area in square inches.
  final double backArea;

  /// Approximate number of 1/4" sheets to buy.
  final int backSheets;

  @override
  List<Object?> get props => [
    stripsPerSheet,
    neededStrips,
    sheets34,
    backArea,
    backSheets,
  ];
}
