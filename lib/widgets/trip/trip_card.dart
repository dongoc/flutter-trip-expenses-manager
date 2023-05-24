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
        color: Colors.white,
        shadowColor: const Color.fromRGBO(56, 96, 255, 0.2),
        elevation: 30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 15,
              height: 120,
              color: isOnTrip(trip.startDate, trip.endDate)
                  ? const Color.fromRGBO(56, 96, 255, 1)
                  : const Color.fromRGBO(56, 96, 255, 0.2),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 20, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        trip.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        child: const Text(
                          '수정하기',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    getPeriodText(trip.startDate, trip.endDate),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
