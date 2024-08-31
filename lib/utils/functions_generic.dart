import 'package:intl/intl.dart';

class FunctionsGeneric {
  String formatCurrency(double value) {
    final currencyFormat = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    return currencyFormat.format(value);
  }
}
