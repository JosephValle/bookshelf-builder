import 'package:bookshelf_builder/features/planner/domain/models/shopping_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_item.freezed.dart';

/// One tool or supply to buy, with how many and what one costs.
@freezed
abstract class ShoppingItem with _$ShoppingItem {
  const ShoppingItem._();

  /// Creates an item.
  const factory ShoppingItem({
    /// Stable key used for the price catalog and the "I own this" checkbox.
    required String id,

    /// What to buy, for example "Wood glue, 16 oz".
    required String name,

    /// Tool or consumable material.
    required ShoppingKind kind,

    /// How many units to buy.
    required int quantity,

    /// Unit name, for example "bottle" or "box".
    required String unit,

    /// Price of one unit from a retailer listing, or null when none has been
    /// recorded yet. A null price is never guessed.
    required double? unitPrice,

    /// False for nice-to-have tools, which are left out of the total.
    @Default(true) bool essential,
  }) = _ShoppingItem;

  /// True for a tool.
  bool get isTool => kind == ShoppingKind.tool;

  /// Quantity times price, or null when the price is unknown.
  double? get total => unitPrice == null ? null : unitPrice! * quantity;
}
