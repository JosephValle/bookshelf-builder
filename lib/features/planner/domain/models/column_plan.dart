import 'package:equatable/equatable.dart';

/// Shelf and divider layout of one side column.
class ColumnPlan extends Equatable {
  /// Creates a column plan.
  const ColumnPlan({
    required this.colW,
    required this.clearW,
    required this.shelves,
    required this.clearH,
    required this.dividers,
    required this.bayW,
  });

  /// Outer column width.
  final double colW;

  /// Clear width between the two column panels.
  final double clearW;

  /// Number of fixed shelves in the column.
  final int shelves;

  /// Clear opening height between shelves.
  final double clearH;

  /// Vertical dividers per opening (zero when the span is short enough).
  final int dividers;

  /// Clear bay width after dividers.
  final double bayW;

  @override
  List<Object?> get props => [colW, clearW, shelves, clearH, dividers, bayW];
}
