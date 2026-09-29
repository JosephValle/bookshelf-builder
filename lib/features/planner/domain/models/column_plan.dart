import 'package:freezed_annotation/freezed_annotation.dart';

part 'column_plan.freezed.dart';

/// Shelf and divider layout of one side column.
@freezed
abstract class ColumnPlan with _$ColumnPlan {
  /// Creates a column plan.
  const factory ColumnPlan({
    /// Outer column width.
    required double colW,

    /// Clear width between the two column panels.
    required double clearW,

    /// Number of fixed shelves in the column.
    required int shelves,

    /// Clear opening height between shelves.
    required double clearH,

    /// Vertical dividers per opening (zero when the span is short enough).
    required int dividers,

    /// Clear bay width after dividers.
    required double bayW,
  }) = _ColumnPlan;
}
