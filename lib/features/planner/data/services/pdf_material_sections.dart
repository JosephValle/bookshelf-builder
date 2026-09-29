import 'package:bookshelf_builder/features/planner/data/services/pdf_card.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_key_value_row.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_styles.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/models/price_catalog.dart';
import 'package:bookshelf_builder/features/planner/domain/models/tool_recommendation.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cost_estimator.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/money_formatter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/tool_recommender.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// The styled cards of the PDF materials section: plywood, estimated cost,
/// recommended tools, buying and wall attachment. Each card mirrors the card
/// of the same name on the Materials tab.
class PdfMaterialSections {
  /// Creates the sections.
  const PdfMaterialSections({
    this.formatter = const InchesFormatter(),
    this.money = const MoneyFormatter(),
    this.estimator = const CostEstimator(),
    this.tools = const ToolRecommender(),
  });

  /// Inch formatting.
  final InchesFormatter formatter;

  /// Dollar formatting.
  final MoneyFormatter money;

  /// Prices the plan.
  final CostEstimator estimator;

  /// Recommends the tools.
  final ToolRecommender tools;

  static String _sheets(int n) => '$n sheet${n == 1 ? '' : 's'}';

  /// Every card, in the order they appear on the Materials tab.
  List<pw.Widget> all(Plan plan) => [
    plywood(plan),
    cost(plan),
    toolChecklist(plan),
    buying(),
    wallAttachment(),
  ];

  /// Sheet counts and edge band length.
  pw.Widget plywood(Plan plan) {
    final s = plan.sheets;
    return PdfCard.build(
      title: 'Plywood',
      children: [
        PdfKeyValueRow.build(
          label: '3/4" plywood',
          caption:
              '${s.neededStrips} strips of ${formatter.format(plan.depthPanel)}, '
              '${s.stripsPerSheet} per 4x8 sheet',
          value: _sheets(s.sheets34),
        ),
        PdfKeyValueRow.build(
          label: '1/4" plywood',
          caption: 'Back panels, approximate',
          value: _sheets(s.backSheets),
        ),
        if (plan.inputs.edgeStiffener)
          PdfKeyValueRow.build(
            label: 'Front edge band',
            caption: 'Solid strips on every horizontal front edge',
            value:
                '${(plan.edgeBandInches / 12).toStringAsFixed(1)} linear feet',
          ),
      ],
    );
  }

  /// One block per store: a row per panel, then the subtotal, tax and total.
  pw.Widget cost(Plan plan) {
    final children = <pw.Widget>[
      pw.Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          PdfCard.chip('ZIP ${PriceCatalog.zip}'),
          PdfCard.chip('Updated ${PriceCatalog.updated}'),
        ],
      ),
      pw.SizedBox(height: 6),
    ];
    for (final store in PriceCatalog.stores) {
      final est = estimator.estimate(plan, store);
      children
        ..add(pw.Text('${store.store} estimate', style: PdfStyles.strong))
        ..add(pw.SizedBox(height: 2));
      for (final l in est.lines) {
        children.add(
          PdfKeyValueRow.build(
            label: l.label,
            caption: l.unitPrice == null
                ? '${l.quantity.toStringAsFixed(0)} ${l.unit}, no price found'
                : '${l.quantity.toStringAsFixed(0)} ${l.unit} x '
                      '${money.format(l.unitPrice!)}',
            value: l.total == null ? '' : money.format(l.total!),
          ),
        );
      }
      if (est.subtotal != null) {
        children
          ..add(pw.Divider(color: PdfStyles.border, thickness: 0.5, height: 8))
          ..add(
            PdfKeyValueRow.build(
              label: 'Estimated subtotal',
              value: money.format(est.subtotal!),
            ),
          )
          ..add(
            PdfKeyValueRow.build(
              label:
                  'Estimated sales tax '
                  '(${(est.taxRate * 100).toStringAsFixed(0)}%)',
              value: money.format(est.tax!),
            ),
          )
          ..add(
            PdfKeyValueRow.build(
              label: 'Estimated total',
              value: money.format(est.total!),
              emphasis: true,
            ),
          );
      }
      children.add(pw.SizedBox(height: 6));
    }
    children.add(pw.Text(PriceCatalog.note, style: PdfStyles.caption));
    return PdfCard.build(title: 'Estimated cost', children: children);
  }

  /// The recommended tools as a checklist with an "Optional" badge on the
  /// nice-to-have items.
  pw.Widget toolChecklist(Plan plan) {
    return PdfCard.build(
      title: 'Recommended tools',
      children: [for (final t in tools.recommend(plan)) _tool(t)],
    );
  }

  pw.Widget _tool(ToolRecommendation t) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 8,
            height: 8,
            margin: const pw.EdgeInsets.only(top: 2, right: 8),
            decoration: pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              color: t.essential ? PdfStyles.accent : PdfColors.white,
              border: pw.Border.all(color: PdfStyles.accent, width: 1),
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Flexible(
                      child: pw.Text(t.name, style: PdfStyles.strong),
                    ),
                    if (!t.essential) ...[
                      pw.SizedBox(width: 6),
                      PdfCard.chip('Optional'),
                    ],
                  ],
                ),
                pw.Text(t.reason, style: PdfStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// The in-store cutting note.
  pw.Widget buying() => PdfCard.build(
    title: 'Buying',
    children: [pw.Text(PlannerNotes.store, style: PdfStyles.body)],
  );

  /// How to attach the unit to the wall.
  pw.Widget wallAttachment() => PdfCard.build(
    title: 'Wall attachment',
    children: [pw.Text(PlannerNotes.wall, style: PdfStyles.body)],
  );
}
