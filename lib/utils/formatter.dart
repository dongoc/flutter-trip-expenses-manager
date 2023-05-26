import 'package:intl/intl.dart';

String formatNumberWithSeparator(int number) {
  return NumberFormat('###,###,000').format(number);
}
