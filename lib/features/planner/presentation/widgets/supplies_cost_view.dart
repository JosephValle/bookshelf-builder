import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/models/shopping_item.dart';
import 'package:bookshelf_builder/features/planner/domain/services/money_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/shopping_list_builder.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/key_value_row.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';

/// Prices the tools and consumable supplies for a plan.
///
/// Each tool has an "I have this" checkbox; a tool that is checked is left out
/// of the total. Optional tools are listed but never counted. Items with no
/// recorded listing price are called out and left out of the total.
class SuppliesCostView extends StatefulWidget {
  /// Creates the view for [plan].
  const SuppliesCostView({required this.plan, super.key});

  /// Plan to price.
  final Plan plan;

  @override
  State<SuppliesCostView> createState() => _SuppliesCostViewState();
}

class _SuppliesCostViewState extends State<SuppliesCostView>
    with AutomaticKeepAliveClientMixin {
  /// Ids of the tools the user already owns.
  final Set<String> _owned = {};

  @override
  bool get wantKeepAlive => true;

  void _toggle(String id, bool have) => setState(() {
    if (have) {
      _owned.add(id);
    } else {
      _owned.remove(id);
    }
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const money = MoneyFormatter();
    final theme = Theme.of(context);
    final items = const ShoppingListBuilder().build(widget.plan);
    final materials = items.where((i) => !i.isTool).toList();
    final tools = items.where((i) => i.isTool).toList();
    final counted = [
      ...materials,
      ...tools.where((t) => t.essential && !_owned.contains(t.id)),
    ];
    final priced = counted.where((i) => i.total != null);
    final unknown = counted.where((i) => i.total == null).length;
    final subtotal = priced.fold<double>(0, (sum, i) => sum + i.total!);
    final tax = subtotal * PriceCatalog.salesTaxRate;
    return SectionCard(
      title: 'Tools and supplies',
      icon: Icons.build_circle_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Supplies', style: theme.textTheme.titleSmall),
          const SizedBox(height: Space.xs),
          for (final m in materials) _line(m, money),
          const SizedBox(height: Space.md),
          Text(
            'Tools (check the ones you have)',
            style: theme.textTheme.titleSmall,
          ),
          for (final t in tools)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: _owned.contains(t.id),
              onChanged: (v) => _toggle(t.id, v ?? false),
              title: Text(t.name),
              subtitle: Text(_caption(t, money)),
              secondary: Text(
                t.essential ? _amount(t, money, _owned.contains(t.id)) : '',
              ),
            ),
          const Divider(),
          KeyValueRow(
            label: 'Tools and supplies subtotal',
            value: money.format(subtotal),
          ),
          KeyValueRow(
            label:
                'Estimated sales tax '
                '(${(PriceCatalog.salesTaxRate * 100).toStringAsFixed(0)}%)',
            value: money.format(tax),
          ),
          KeyValueRow(
            label: 'Tools and supplies total',
            value: money.format(subtotal + tax),
            emphasis: true,
          ),
          Text(
            PriceCatalog.supplyNote,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (unknown > 0)
            Text(
              '$unknown item${unknown == 1 ? '' : 's'} with an unknown price '
              'are not in this total.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }

  Widget _line(ShoppingItem item, MoneyFormatter money) => KeyValueRow(
    label: item.name,
    caption: _caption(item, money),
    value: item.total == null ? 'unknown' : money.format(item.total!),
  );

  String _caption(ShoppingItem item, MoneyFormatter money) {
    final base = '${item.quantity} ${item.unit}';
    final price = item.unitPrice == null
        ? 'price unknown'
        : 'x ${money.format(item.unitPrice!)}';
    return item.essential ? '$base, $price' : '$base, $price, optional';
  }

  String _amount(ShoppingItem item, MoneyFormatter money, bool owned) {
    if (owned) return 'owned';
    return item.total == null ? 'unknown' : money.format(item.total!);
  }
}
