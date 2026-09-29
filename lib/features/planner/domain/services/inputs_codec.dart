import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';

/// Converts [Inputs] to and from a JSON friendly map.
///
/// Decoding is forgiving: missing or wrongly typed fields fall back to their
/// defaults, so an old or damaged saved copy never breaks the app.
class InputsCodec {
  /// Creates a codec.
  const InputsCodec();

  /// Encodes [i]. Unset optional fields are omitted.
  Map<String, Object?> encode(Inputs i) => {
    'windowW': i.windowW,
    'windowH': i.windowH,
    'trimTop': i.trimTop,
    'trimBottom': i.trimBottom,
    'trimLeft': i.trimLeft,
    'trimRight': i.trimRight,
    'gapTop': i.gapTop,
    'gapBottom': i.gapBottom,
    'gapLeft': i.gapLeft,
    'gapRight': i.gapRight,
    'left': i.left,
    'right': i.right,
    'top': i.top,
    'bottom': i.bottom,
    'depth': i.depth,
    'onFloor': i.onFloor,
    'toeKick': i.toeKick,
    'targetClearH': i.targetClearH,
    'edgeStiffener': i.edgeStiffener,
    'maxShelfWidth': i.maxShelfWidth,
    'fillWall': i.fillWall,
    if (i.wallW != null) 'wallW': i.wallW,
    if (i.wallH != null) 'wallH': i.wallH,
    'wallMarginTop': i.wallMarginTop,
    'wallMarginLeft': i.wallMarginLeft,
    'wallMarginRight': i.wallMarginRight,
    if (i.windowFromFloor != null) 'windowFromFloor': i.windowFromFloor,
    if (i.windowFromWallLeft != null)
      'windowFromWallLeft': i.windowFromWallLeft,
  };

  /// Decodes a map produced by [encode], using defaults for anything invalid.
  Inputs decode(Map<String, Object?> m) {
    const d = Inputs();
    double positive(String k, double fallback) {
      final v = m[k];
      return v is num && v.isFinite && v > 0 ? v.toDouble() : fallback;
    }

    double? opt(String k) {
      final v = m[k];
      return v is num && v.isFinite && v >= 0 ? v.toDouble() : null;
    }

    bool flag(String k, bool fallback) {
      final v = m[k];
      return v is bool ? v : fallback;
    }

    return Inputs(
      windowW: positive('windowW', d.windowW),
      windowH: positive('windowH', d.windowH),
      trimTop: opt('trimTop') ?? 0,
      trimBottom: opt('trimBottom') ?? 0,
      trimLeft: opt('trimLeft') ?? 0,
      trimRight: opt('trimRight') ?? 0,
      gapTop: opt('gapTop') ?? 0,
      gapBottom: opt('gapBottom') ?? 0,
      gapLeft: opt('gapLeft') ?? 0,
      gapRight: opt('gapRight') ?? 0,
      left: positive('left', d.left),
      right: positive('right', d.right),
      top: positive('top', d.top),
      bottom: positive('bottom', d.bottom),
      depth: positive('depth', d.depth),
      onFloor: flag('onFloor', d.onFloor),
      toeKick: positive('toeKick', d.toeKick),
      targetClearH: positive('targetClearH', d.targetClearH),
      edgeStiffener: flag('edgeStiffener', d.edgeStiffener),
      maxShelfWidth: positive('maxShelfWidth', d.maxShelfWidth),
      fillWall: flag('fillWall', d.fillWall),
      wallW: opt('wallW'),
      wallH: opt('wallH'),
      wallMarginTop: opt('wallMarginTop') ?? 0,
      wallMarginLeft: opt('wallMarginLeft') ?? 0,
      wallMarginRight: opt('wallMarginRight') ?? 0,
      windowFromWallLeft: opt('windowFromWallLeft'),
      windowFromFloor: opt('windowFromFloor'),
    );
  }
}
