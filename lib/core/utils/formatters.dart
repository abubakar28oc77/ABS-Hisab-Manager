import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  // Bengali Taka symbol for in-app display (Android/web font fallback renders it fine).
  static final NumberFormat _currency = NumberFormat.currency(
    symbol: '৳',
    decimalDigits: 2,
  );

  static String currency(double value) => _currency.format(value);

  // PDF documents use default (non-Bengali) fonts, so use plain "Tk" prefix
  // there to avoid missing-glyph boxes for the Taka sign.
  static final NumberFormat _currencyPdf = NumberFormat.currency(
    symbol: 'Tk ',
    decimalDigits: 2,
  );

  static String currencyPdf(double value) => _currencyPdf.format(value);

  static final DateFormat _date = DateFormat('MMM d, yyyy');
  static String date(DateTime d) => _date.format(d);

  static final DateFormat _monthYear = DateFormat('MMMM yyyy');
  static String monthYear(int month, int year) =>
      _monthYear.format(DateTime(year, month));
}
