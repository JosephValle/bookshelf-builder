import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_plan.freezed.dart';

/// Divider and tier layout of the top or bottom bar.
@freezed
abstract class BarPlan with _$BarPlan {
  /// Creates a bar plan.
  const factory BarPlan({
    /// Number of vertical dividers across the window width.
    required int dividers,

    /// Length of each divider (the bar clear height).
    required double dividerLength,

    /// Clear bay width between dividers.
    required double bayW,

    /// Clear height inside the bar.
    required double clearH,

    /// One or two rows of bays.
    required int tiers,
  }) = _BarPlan;
}
