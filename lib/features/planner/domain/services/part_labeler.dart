import 'package:bookshelf_builder/features/planner/domain/models/part.dart';

/// Gives every part a piece letter, so parts with the same material and size
/// share one letter, and numbers every physical piece within its letter: two
/// identical long panels are pieces `A1` and `A2`.
class PartLabeler {
  /// Creates a labeler.
  const PartLabeler();

  /// Letters used for labels. `I` and `O` are left out because they are easy
  /// to mistake for `1` and `0` when written in pencil on a board.
  static const String alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ';

  /// Returns [parts] with a label on each, in order of first appearance.
  List<Part> label(List<Part> parts) {
    final letters = <String, String>{};
    final used = <String, int>{};
    return [for (final p in parts) _number(p, letters, used)];
  }

  Part _number(Part p, Map<String, String> letters, Map<String, int> used) {
    final l = letters.putIfAbsent(_key(p), () => labelFor(letters.length));
    final first = (used[l] ?? 0) + 1;
    used[l] = first - 1 + p.qty;
    return p.withLabel(l, firstNumber: first);
  }

  /// The letter for the zero based [index]: A, B, ... Z, then AA, AB, and so
  /// on (skipping `I` and `O`).
  static String labelFor(int index) {
    const n = alphabet.length;
    if (index < n) return alphabet[index];
    return alphabet[index ~/ n - 1] + alphabet[index % n];
  }

  /// Two parts are the same piece when this key matches. Sizes are compared
  /// to 1/1000 inch so tiny float differences do not split a group.
  String _key(Part p) =>
      '${p.material.name}|${_milli(p.length)}|${_milli(p.width)}|'
      '${_milli(p.splicedFrom)}';

  int _milli(double v) => (v * 1000).round();
}
