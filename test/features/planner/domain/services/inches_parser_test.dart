import 'package:bookshelf_builder/features/planner/domain/services/inches_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const p = InchesParser();

  group('parse', () {
    test('decimals', () => expect(p.parse('11.25'), 11.25));
    test('integers', () => expect(p.parse('48'), 48));
    test('mixed fractions', () => expect(p.parse('11 1/4'), 11.25));
    test('hyphenated fractions', () => expect(p.parse('11-1/4'), 11.25));
    test('fraction only', () => expect(p.parse('3/4'), 0.75));
    test('strips the inch mark', () => expect(p.parse('11 1/4"'), 11.25));
    test('trims whitespace', () => expect(p.parse('  7  '), 7));
    test('empty is null', () => expect(p.parse(''), isNull));
    test('blank is null', () => expect(p.parse('   '), isNull));
    test('letters are null', () => expect(p.parse('abc'), isNull));
    test('bad fraction is null', () => expect(p.parse('1/'), isNull));
    test('zero denominator is null', () => expect(p.parse('1/0'), isNull));
    test('double slash is null', () => expect(p.parse('1/2/3'), isNull));
  });
}
