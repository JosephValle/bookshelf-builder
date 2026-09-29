import 'package:bookshelf_builder/features/planner/domain/models/cost_line.dart';
import 'package:bookshelf_builder/features/planner/domain/models/store_prices.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_estimate.freezed.dart';

/// The estimated cost of a plan at one store.
@freezed
abstract class CostEstimate with _$CostEstimate {
  const CostEstimate._();

  /// Creates an estimate.
  const factory CostEstimate({
    /// Prices the estimate used.
    required StorePrices prices,

    /// What to buy and what it costs.
    required List<CostLine> lines,

    /// Sales tax rate applied to the subtotal, for example 0.07.
    @Default(0) double taxRate,
  }) = _CostEstimate;

  /// Lines with no price.
  List<CostLine> get missing =>
      lines.where((l) => l.unitPrice == null).toList();

  /// True when every line has a price.
  bool get isComplete => missing.isEmpty;

  /// Sum of every line before tax, or null when any price is missing.
  double? get subtotal => isComplete ? pricedSubtotal : null;

  /// Sales tax on the [subtotal], or null when any price is missing.
  double? get tax => subtotal == null ? null : subtotal! * taxRate;

  /// The [subtotal] plus [tax], or null when any price is missing.
  double? get total => subtotal == null ? null : subtotal! + tax!;

  /// Sum of the lines that do have a price.
  double get pricedSubtotal =>
      lines.fold<double>(0, (sum, l) => sum + (l.total ?? 0));
}
