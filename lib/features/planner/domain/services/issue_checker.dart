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
    if (inputs.windowW > Limits.maxWindowSpan + 1e-9) {
      add(
        Severity.error,
        'Window is ${f(inputs.windowW)} wide, over the ${f(Limits.maxWindowSpan)} maxWindowSpan. Add a steel angle or mid-span support.',
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
    if (wallW != null && dims.ringW > wallW + 1e-9) {
      add(
        Severity.error,
        'Ring width ${f(dims.ringW)} exceeds wall width ${f(wallW)}.',
      );
    }
    if (wallH != null) {
      if (dims.ringH > wallH + 1e-9) {
        add(
          Severity.error,
          'Ring height ${f(dims.ringH)} exceeds wall height ${f(wallH)}.',
        );
      } else if (wallH - dims.ringH < Limits.ceilingClearanceMin) {
        add(
          Severity.warning,
          'Ceiling clearance is ${f(wallH - dims.ringH)}, under ${f(Limits.ceilingClearanceMin)}.',
        );
      }
    }
    final offset = inputs.ringOffsetFromLeft;
    if (wallW != null && offset != null) {
      if (offset < 0 || offset + dims.ringW > wallW + 1e-9) {
        add(
          Severity.error,
          'Ring at ${f(offset)} from the left does not fit on the wall.',
        );
      }
    }
    if (!inputs.onFloor) {
      add(Severity.note, 'Not on floor: the bottom bar needs a support plan.');
    }
    return issues;
  }
}
