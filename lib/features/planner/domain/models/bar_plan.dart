import 'package:equatable/equatable.dart';

/// Divider and tier layout of the top or bottom bar.
class BarPlan extends Equatable {
  /// Creates a bar plan.
  const BarPlan({
    required this.dividers,
    required this.dividerLength,
    required this.bayW,
    required this.clearH,
    required this.tiers,
  });

  /// Number of vertical dividers across the window width.
  final int dividers;

  /// Length of each divider (the bar clear height).
  final double dividerLength;

  /// Clear bay width between dividers.
  final double bayW;

  /// Clear height inside the bar.
  final double clearH;

  /// One or two rows of bays.
  final int tiers;

  @override
  List<Object?> get props => [dividers, dividerLength, bayW, clearH, tiers];
}
