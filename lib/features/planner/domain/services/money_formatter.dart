/// Formats dollar amounts, for example `$1,234.50`.
class MoneyFormatter {
  /// Creates a formatter.
  const MoneyFormatter();

  /// Formats [v] with a dollar sign, thousands separators and cents.
  String format(double v) {
    final cents = (v.abs() * 100).round();
    final whole = (cents ~/ 100).toString();
    final frac = (cents % 100).toString().padLeft(2, '0');
    final grouped = whole.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (m) => ',',
    );
    final sign = v < 0 && cents != 0 ? '-' : '';
    return '$sign\$$grouped.$frac';
  }
}
