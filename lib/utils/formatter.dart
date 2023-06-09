import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

String formatNumberWithSeparator(int number) {
  return NumberFormat('###,###,000').format(number);
}

String getPeriodText(DateTime startDate, DateTime? endDate) {
  int period = endDate != null ? endDate.difference(startDate).inDays + 1 : 1;

  String formattedStartDate =
      formatDate(startDate, [yyyy, '년 ', mm, '월 ', dd, '일']);
  String? formattedEndDate = endDate != null
      ? formatDate(endDate, [yyyy, '년 ', mm, '월 ', dd, '일'])
      : null;
  return '$formattedStartDate${formattedEndDate != null ? ' ~ $formattedEndDate' : ''} ($period일)';
}
