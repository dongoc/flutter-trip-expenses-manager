import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/screens/trip_form_screen.dart';

import '../models/trip.dart';
import '../types/form.dart';
import '../widgets/form/button.dart';
import '../widgets/trip/trip_card.dart';

List<Trip> tripList = [
  Trip(
    id: "1",
    title: "경주 여행",
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  ),
  Trip(
    id: "2",
    title: "삿포로 여행",
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  ),
  Trip(
    id: "3",
    title: "파리 여행",
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  ),
  Trip(
    id: "4",
    title: "홍콩 여행",
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  ),
];

class TripListScreen extends StatelessWidget {
  const TripListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("여행 목록"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return TripCard(trip: tripList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 2,
          );
        },
        itemCount: tripList.length,
      ),
      persistentFooterButtons: [
        FloatingButton(
            text: '새로운 여행 추가하기',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const TripFormScreen(formType: FormType.create),
                  ));
            })
      ],
    );
  }
}
