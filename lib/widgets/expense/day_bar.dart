import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../../utils/formatter.dart';

class DayBar extends StatelessWidget {
  final int currentDay, period, totalAmount;
  final DateTime startDate;

  const DayBar({
    super.key,
    this.totalAmount = 0,
    required this.currentDay,
    required this.period,
    required this.startDate,
  });

  String getDayBarTitle() {
    if (currentDay == 0) return '여행 전';
    if (currentDay == period + 1) return '여행 후';

    String formattedDate = formatDate(
        startDate.add(Duration(days: currentDay - 1)),
        [yyyy, "년 ", mm, '월 ', dd, '일']);
    return '$currentDay일차 ($formattedDate)';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(getDayBarTitle()),
        Text('${formatNumberWithSeparator(totalAmount)} 원'),
      ],
    );
  }
}
