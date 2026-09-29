import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inputs_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const codec = InputsCodec();

  group('encode and decode', () {
    test('defaults round trip', () {
      expect(codec.decode(codec.encode(const Inputs())), const Inputs());
    });

    test('every field round trips', () {
      const i = Inputs(
        windowW: 40,
        windowH: 52,
        left: 12,
        right: 15,
        top: 13,
        bottom: 16,
        depth: 9.25,
        onFloor: false,
        toeKick: 4,
        targetClearH: 8,
        edgeStiffener: true,
        maxShelfWidth: 18,
        fillWall: false,
        wallW: 120,
        wallH: 96,
        wallMarginTop: 3,
        wallMarginLeft: 4,
        wallMarginRight: 5,
        windowFromWallLeft: 30,
        windowFromFloor: 20,
        gapTop: 1,
        gapBottom: 2,
        gapLeft: 0.5,
        gapRight: 0.25,
      );
      expect(codec.decode(codec.encode(i)), i);
    });

    test('unset optional fields are omitted when encoding', () {
      final m = codec.encode(const Inputs());
      expect(m.containsKey('wallW'), isFalse);
      expect(m.containsKey('wallH'), isFalse);
      expect(m.containsKey('windowFromWallLeft'), isFalse);
      expect(m.containsKey('windowFromFloor'), isFalse);
    });

    test('encoded values are JSON friendly', () {
      final m = codec.encode(const Inputs(wallW: 100));
      for (final v in m.values) {
        expect(v is num || v is bool, isTrue);
      }
    });
  });

  group('decode is forgiving', () {
    test('an empty map gives the defaults', () {
      expect(codec.decode({}), const Inputs());
    });

    test('wrongly typed fields fall back to defaults', () {
      final i = codec.decode({
        'windowW': 'wide',
        'left': null,
        'onFloor': 'yes',
        'fillWall': 3,
        'wallW': 'x',
      });
      expect(i, const Inputs());
    });

    test('non-positive required lengths fall back to defaults', () {
      final i = codec.decode({'windowW': 0, 'left': -4, 'depth': -1});
      expect(i.windowW, 48);
      expect(i.left, 14);
      expect(i.depth, 11.25);
    });

    test('non-finite numbers fall back to defaults', () {
      final i = codec.decode({'windowW': double.infinity, 'wallW': double.nan});
      expect(i.windowW, 48);
      expect(i.wallW, isNull);
    });

    test('negative optional values are dropped', () {
      final i = codec.decode({'wallW': -5, 'gapTop': -1});
      expect(i.wallW, isNull);
      expect(i.gapTop, 0);
    });

    test('integers are accepted as lengths', () {
      final i = codec.decode({'windowW': 50, 'wallMarginLeft': 6});
      expect(i.windowW, 50);
      expect(i.wallMarginLeft, 6);
    });

    test('unknown keys are ignored', () {
      expect(codec.decode({'mystery': 1}), const Inputs());
    });

    test('older saves without new fields still load', () {
      final i = codec.decode({'windowW': 44, 'left': 12});
      expect(i.windowW, 44);
      expect(i.left, 12);
      expect(i.maxShelfWidth, 24);
      expect(i.fillWall, isTrue);
      expect(i.gapLeft, 0);
    });
  });
}
