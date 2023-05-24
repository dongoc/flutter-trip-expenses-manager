import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/screens/trip_form_screen.dart';

import '../static/trip_list.dart';
import '../types/form.dart';
import '../widgets/trip/trip_card.dart';

class TripListScreen extends StatelessWidget {
  const TripListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("여행 목록"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
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
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const TripFormScreen(formType: FormType.create),
              ));
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
        // shape: const RoundedRectangleBorder(),
        child: const Text('새로운 여행 추가하기'),
      ),
    );
  }
}
