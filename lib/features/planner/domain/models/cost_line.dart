import 'package:equatable/equatable.dart';

/// One line of a cost estimate.
class CostLine extends Equatable {
  /// Creates a line.
  const CostLine({
    required this.label,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
  });

  /// What is being bought.
  final String label;

  /// How many units.
  final double quantity;

  /// Unit name: "sheet" or "ft".
  final String unit;

  /// Price per unit, or null when it has not been found.
  final double? unitPrice;

  /// Quantity times price, or null when the price is missing.
  double? get total => unitPrice == null ? null : unitPrice! * quantity;

  @override
  List<Object?> get props => [label, quantity, unit, unitPrice];
}
