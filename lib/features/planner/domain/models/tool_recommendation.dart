import 'package:freezed_annotation/freezed_annotation.dart';

part 'tool_recommendation.freezed.dart';

/// One recommended tool or supply.
@freezed
abstract class ToolRecommendation with _$ToolRecommendation {
  /// Creates a recommendation.
  const factory ToolRecommendation({
    /// What to get, for example "Cordless drill/driver".
    required String name,

    /// Why this plan needs it.
    required String reason,

    /// False for nice-to-have items.
    @Default(true) bool essential,
  }) = _ToolRecommendation;
}
