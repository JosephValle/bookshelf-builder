import 'package:bookshelf_builder/features/planner/domain/models/shopping_kind.dart';
import 'package:equatable/equatable.dart';

/// One tool or supply to buy, with how many and what one costs.
class ShoppingItem extends Equatable {
  /// Creates an item.
  const ShoppingItem({
    required this.id,
    required this.name,
    required this.kind,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    this.essential = true,
  });

  /// Stable key used for the price catalog and the "I own this" checkbox.
  final String id;

  /// What to buy, for example "Wood glue, 16 oz".
  final String name;

  /// Tool or consumable material.
  final ShoppingKind kind;

  /// How many units to buy.
  final int quantity;

  /// Unit name, for example "bottle" or "box".
  final String unit;

  /// Price of one unit from a retailer listing, or null when none has been
  /// recorded yet. A null price is never guessed.
  final double? unitPrice;

  /// False for nice-to-have tools, which are left out of the total.
  final bool essential;

  /// True for a tool.
  bool get isTool => kind == ShoppingKind.tool;

  /// Quantity times price, or null when the price is unknown.
  double? get total => unitPrice == null ? null : unitPrice! * quantity;

  @override
  List<Object?> get props => [
    id,
    name,
    kind,
    quantity,
    unit,
    unitPrice,
    essential,
  ];
}
