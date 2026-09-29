import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';

/// Converts [Inputs] to and from a JSON friendly map.
///
/// The map itself is generated (`Inputs.toJson` and `Inputs.fromJson`). This
/// class adds the forgiving part: decoding checks every value first, so a
/// missing or wrongly typed field falls back to its default and an old or
/// damaged saved copy never breaks the app.
class InputsCodec {
  /// Creates a codec.
  const InputsCodec();

  /// Optional fields that stay unset (null) unless the value is a number of
  /// zero or more.
  static const Set<String> _optional = {
    'wallW',
    'wallH',
    'windowFromWallLeft',
    'windowFromFloor',
  };

  /// Fields that may be zero: trim, gaps and wall margins.
  static const Set<String> _zeroAllowed = {
    'trimTop',
    'trimBottom',
    'trimLeft',
    'trimRight',
    'gapTop',
    'gapBottom',
    'gapLeft',
    'gapRight',
    'wallMarginTop',
    'wallMarginLeft',
    'wallMarginRight',
  };

  /// Encodes [i]. Unset optional fields are omitted.
  Map<String, Object?> encode(Inputs i) =>
      Map<String, Object?>.of(i.toJson())..removeWhere((_, v) => v == null);

  /// Decodes a map produced by [encode], using defaults for anything invalid.
  Inputs decode(Map<String, Object?> m) {
    final clean = <String, Object?>{};
    for (final e in const Inputs().toJson().entries) {
      final v = m[e.key];
      if (e.value is bool) {
        if (v is bool) clean[e.key] = v;
      } else if (v is num && v.isFinite) {
        final ok = _optional.contains(e.key) || _zeroAllowed.contains(e.key)
            ? v >= 0
            : v > 0;
        if (ok) clean[e.key] = v.toDouble();
      }
    }
    return Inputs.fromJson(clean);
  }
}
