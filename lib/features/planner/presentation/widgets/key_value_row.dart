import 'package:bookshelf_builder/app/theme/space.dart';
import 'package:flutter/material.dart';

/// A label on the left and a right-aligned value, with an optional muted
/// caption under the label. [emphasis] makes the row bold and larger, for
/// totals.
class KeyValueRow extends StatelessWidget {
  /// Creates a row.
  const KeyValueRow({
    required this.label,
    required this.value,
    this.caption,
    this.emphasis = false,
    super.key,
  });

  /// Text on the left.
  final String label;

  /// Text on the right.
  final String value;

  /// Muted line under the label.
  final String? caption;

  /// Whether to style the row as a total.
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base = emphasis
        ? theme.textTheme.titleMedium
        : theme.textTheme.bodyMedium;
    final strong = base?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: emphasis ? strong : base),
                if (caption != null)
                  Text(
                    caption!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: Space.md),
          Text(value, style: strong, textAlign: TextAlign.right),
        ],
      ),
    );
  }
}
