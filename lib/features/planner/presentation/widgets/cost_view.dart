import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:bookshelf_builder/features/planner/domain/models/cost_estimate.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cost_estimator.dart';
import 'package:bookshelf_builder/features/planner/domain/services/money_formatter.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/key_value_row.dart';
import 'package:bookshelf_builder/features/planner/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';

/// Estimated cost per panel, subtotal, tax and total at each store, with the
/// ZIP code and the date the reference prices were last updated.
class CostView extends StatelessWidget {
  /// Creates the view for [plan].
  const CostView({required this.plan, super.key});

  /// Plan to price.
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    const estimator = CostEstimator();
    const money = MoneyFormatter();
    return SectionCard(
      title: 'Estimated cost',
      icon: Icons.payments_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Wrap(
            spacing: Space.sm,
            runSpacing: Space.xs,
            children: [
              Chip(
                visualDensity: VisualDensity.compact,
                label: Text('ZIP ${PriceCatalog.zip}'),
              ),
              Chip(
                visualDensity: VisualDensity.compact,
                label: Text('Updated ${PriceCatalog.updated}'),
              ),
            ],
          ),
          const SizedBox(height: Space.sm),
          for (final store in PriceCatalog.stores)
            _StoreCost(estimate: estimator.estimate(plan, store), money: money),
          Text(
            PriceCatalog.note,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreCost extends StatelessWidget {
  const _StoreCost({required this.estimate, required this.money});

  final CostEstimate estimate;
  final MoneyFormatter money;

  @override
  Widget build(BuildContext context) {
    final subtotal = estimate.subtotal;
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${estimate.prices.store} estimate',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: Space.xs),
          for (final l in estimate.lines)
            KeyValueRow(
              label: l.label,
              caption: l.unitPrice == null
                  ? '${l.quantity.toStringAsFixed(0)} ${l.unit}, no price found'
                  : '${l.quantity.toStringAsFixed(0)} ${l.unit} x '
                        '${money.format(l.unitPrice!)}',
              value: l.total == null ? '' : money.format(l.total!),
            ),
          if (subtotal != null) ...[
            const Divider(),
            KeyValueRow(
              label: 'Estimated subtotal',
              value: money.format(subtotal),
            ),
            KeyValueRow(
              label:
                  'Estimated sales tax '
                  '(${(estimate.taxRate * 100).toStringAsFixed(0)}%)',
              value: money.format(estimate.tax!),
            ),
            KeyValueRow(
              label: 'Estimated total',
              value: money.format(estimate.total!),
              emphasis: true,
            ),
          ] else
            const Text('price not found'),
        ],
      ),
    );
  }
}
