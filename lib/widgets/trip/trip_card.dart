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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(trip.title),
              Text(trip.startDate.toString()),
              Text(trip.endDate.toString()),
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
