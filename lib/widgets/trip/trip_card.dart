import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/screens/expense_list_screen.dart';
import 'package:trip_expenses_manager/screens/trip_form_screen.dart';
import 'package:trip_expenses_manager/types/form.dart';

import '../../models/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({
    super.key,
    required this.trip,
  });

  String getPeriodText(DateTime startDate, DateTime? endDate) {
    int period = trip.getTripPeriod();
    String formattedStartDate =
        formatDate(startDate, [yyyy, '년 ', mm, '월 ', dd, '일']);
    String? formattedEndDate = endDate != null
        ? formatDate(endDate, [yyyy, '년 ', mm, '월 ', dd, '일'])
        : null;
    return '$formattedStartDate${formattedEndDate != null ? ' ~ $formattedEndDate' : ''} ($period일)';
  }

  bool isOnTrip(DateTime startDate, DateTime? endDate) {
    DateTime today = DateTime.now();

    if (endDate != null) {
      return startDate.isBefore(today) && endDate.isAfter(today);
    }
    return startDate.isAtSameMomentAs(today);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExpenseListScreen(
                trip: trip,
              ),
            ));
      },
      child: Card(
        color:
            isOnTrip(trip.startDate, trip.endDate) ? Colors.blue : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(trip.title),
              Text(getPeriodText(trip.startDate, trip.endDate)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TripFormScreen(
                            formType: FormType.update,
                          ),
                        ));
                  },
                  child: const Text('수정하기')),
            ],
          ),
        ),
      ),
    );
  }
}
