import 'package:freezed_annotation/freezed_annotation.dart';

part 'sheet_plan.freezed.dart';

/// Plywood sheet estimate.
@freezed
abstract class SheetPlan with _$SheetPlan {
  /// Creates a sheet estimate.
  const factory SheetPlan({
    /// Strips of panel depth that one 4x8 sheet yields.
    required int stripsPerSheet,

    /// Strips of full sheet length needed for all 3/4" parts.
    required int neededStrips,

    /// Number of 3/4" sheets to buy.
    required int sheets34,

    /// Total 1/4" back panel area in square inches.
    required double backArea,

    /// Approximate number of 1/4" sheets to buy.
    required int backSheets,
  }) = _SheetPlan;
}
