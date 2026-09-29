import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_line.freezed.dart';

/// One line of a cost estimate.
@freezed
abstract class CostLine with _$CostLine {
  const CostLine._();

  /// Creates a line.
  const factory CostLine({
    /// What is being bought.
    required String label,

    /// How many units.
    required double quantity,

    /// Unit name: "sheet" or "ft".
    required String unit,

    /// Price per unit, or null when it has not been found.
    required double? unitPrice,
  }) = _CostLine;

  /// Quantity times price, or null when the price is missing.
  double? get total => unitPrice == null ? null : unitPrice! * quantity;
}
