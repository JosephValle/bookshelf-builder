/// Parses typed inch values such as `11.25`, `11 1/4`, `11-1/4` or `3/4"`.
class InchesParser {
  /// Creates a parser.
  const InchesParser();

  /// Returns the value in inches, or null when [input] is not a valid length.
  double? parse(String input) {
    final s = input.trim().replaceAll('"', '').replaceAll('-', ' ');
    if (s.isEmpty) return null;
    var total = 0.0;
    for (final piece in s.split(RegExp(r'\s+'))) {
      if (piece.contains('/')) {
        final f = piece.split('/');
        if (f.length != 2) return null;
        final n = double.tryParse(f[0]);
        final d = double.tryParse(f[1]);
        if (n == null || d == null || d == 0) return null;
        total += n / d;
      } else {
        final v = double.tryParse(piece);
        if (v == null) return null;
        total += v;
      }
    }
    return total;
  }
}
