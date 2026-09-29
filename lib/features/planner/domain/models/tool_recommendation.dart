import 'package:equatable/equatable.dart';

/// One recommended tool or supply.
class ToolRecommendation extends Equatable {
  /// Creates a recommendation.
  const ToolRecommendation({
    required this.name,
    required this.reason,
    this.essential = true,
  });

  /// What to get, for example "Cordless drill/driver".
  final String name;

  /// Why this plan needs it.
  final String reason;

  /// False for nice-to-have items.
  final bool essential;

  @override
  List<Object?> get props => [name, reason, essential];
}
