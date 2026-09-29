import 'package:bookshelf_builder/features/planner/domain/models/bay.dart';
import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/issue.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';

/// Produces the live warnings, errors and notes for a plan.
class IssueChecker {
  /// Creates a checker.
  const IssueChecker({this.formatter = const InchesFormatter()});

  /// Inch formatting used in messages.
  final InchesFormatter formatter;

  /// Checks [inputs], the derived [dims], the [parts] and the [bays].
  ///
  /// When a wall width is set the ring position (the user's offset, or the
  /// window centered on the wall) must also fit within the wall.
  List<Issue> check({
    required Inputs inputs,
    required Dimensions dims,
    required List<Part> parts,
    required List<Bay> bays,
  }) {
    final f = formatter.format;
    final issues = <Issue>[];
    void add(Severity s, String m) => issues.add(Issue(s, m));

    void outer(String name, double v, double min) {
      if (v < min - 1e-9) {
        add(
          Severity.warning,
          '$name is ${f(v)}, below the ${f(min)} minimum section (minOuterSection).',
        );
      }
    }

    outer('Left column', inputs.left, Limits.minOuterSection);
    outer('Right column', inputs.right, Limits.minOuterSection);
    outer('Top bar', inputs.top, Limits.minOuterSection);
    outer('Bottom bar', inputs.bottom, Limits.minOuterSection + dims.kick);

    for (final b in bays) {
      if (b.box.w < Limits.minClearW - 1e-9) {
        add(
          Severity.warning,
          'A bay is ${f(b.box.w)} wide, below the ${f(Limits.minClearW)} minimum clear width.',
        );
        break;
      }
    }
    for (final b in bays) {
      if (b.box.h < Limits.minClearH - 1e-9) {
        add(
          Severity.warning,
          'A bay is ${f(b.box.h)} tall, below the ${f(Limits.minClearH)} minimum clear height.',
        );
        break;
      }
    }
    if (inputs.depth < Limits.minDepth - 1e-9 ||
        inputs.depth > Limits.maxDepth + 1e-9) {
      add(
        Severity.warning,
        'Depth ${f(inputs.depth)} is outside ${f(Limits.minDepth)} to ${f(Limits.maxDepth)}.',
      );
    }
    if (inputs.openW > Limits.maxWindowSpan + 1e-9) {
      add(
        Severity.error,
        'Window opening is ${f(inputs.openW)} wide (window plus gaps), over the ${f(Limits.maxWindowSpan)} maxWindowSpan. Add a steel angle or mid-span support.',
      );
    }
    for (final p in parts) {
      if (p.material != PartMaterial.edgeBand &&
          p.length > Limits.sheetL + 1e-9) {
        add(
          Severity.warning,
          '${p.name} is ${f(p.length)} long, over the ${f(Limits.sheetL)} sheet length. Reduce ring height or plan a spliced part.',
        );
      }
    }

    final wallW = inputs.wallW;
    final wallH = inputs.wallH;
    final usable = inputs.usableWallW;
    if (wallW != null && usable != null) {
      if (usable < inputs.openW - 1e-9) {
        add(
          Severity.error,
          'Only ${f(usable)} of the wall is available between the margins, narrower than the ${f(inputs.openW)} window opening.',
        );
      } else if (dims.ringW > usable + 1e-9) {
        add(
          Severity.error,
          'Ring width ${f(dims.ringW)} exceeds the ${f(usable)} available on the wall.',
        );
      } else {
        final offset = inputs.effectiveRingOffset!;
        if (offset < inputs.wallMarginLeft - 1e-9 ||
            offset + dims.ringW > wallW - inputs.wallMarginRight + 1e-9) {
          add(
            Severity.error,
            'At this window position the ring runs into a wall margin or off the wall. Move the window or widen the columns.',
          );
        }
      }
    }
    if (wallH != null) {
      final available = wallH - inputs.wallMarginTop;
      if (available < inputs.openH - 1e-9) {
        add(
          Severity.error,
          'Only ${f(available)} of the wall height is available under the top margin, shorter than the ${f(inputs.openH)} window opening.',
        );
      } else if (dims.ringH > available + 1e-9) {
        add(
          Severity.error,
          'Ring height ${f(dims.ringH)} exceeds the ${f(available)} available under the top margin.',
        );
      } else if (available - dims.ringH < Limits.ceilingClearanceMin) {
        add(
          Severity.warning,
          'Clearance under the top margin is ${f(available - dims.ringH)}, under ${f(Limits.ceilingClearanceMin)}.',
        );
      }
    }
    if (!inputs.onFloor) {
      add(Severity.note, 'Not on floor: the bottom bar needs a support plan.');
    }
    return issues;
  }
}
