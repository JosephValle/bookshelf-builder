import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';

/// Looks up the piece ids (`A1`, `B3`) of a plan's parts by name, so the
/// assembly guide and its diagrams can say exactly which piece goes where.
class PieceIds {
  /// Creates a lookup for [plan].
  PieceIds(Plan plan) : _byName = {for (final p in plan.parts) p.name: p};

  final Map<String, Part> _byName;

  /// Every id of the part called [name], or an empty list when the plan has
  /// no such part.
  List<String> ids(String name) => _byName[name]?.ids ?? const [];

  /// The id of piece number [index] (zero based) of [name]. Falls back to the
  /// part name when the piece does not exist, so text never has a hole.
  String id(String name, [int index = 0]) {
    final all = ids(name);
    return index < all.length ? all[index] : name.toLowerCase();
  }

  /// The letter shared by every piece of [name], or empty when unknown.
  String label(String name) => _byName[name]?.label ?? '';
}
