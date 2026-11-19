import 'package:intl/intl.dart';

abstract final class AmountFormatter {
  static const String currency = 'EGP';

  static final NumberFormat _whole = NumberFormat('#,##0', 'en_US');
  static final NumberFormat _fraction = NumberFormat('#,##0.00', 'en_US');

  static String number(double value) {
    final isWhole = value == value.roundToDouble();
    return (isWhole ? _whole : _fraction).format(value);
  }

  static String money(double value) => '${number(value)} $currency';

  static String signedMoney(double value) {
    if (value == 0) return money(0);
    final sign = value > 0 ? '+' : '-';
    return '$sign${money(value.abs())}';
  }
}
