import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/screens/trip_form_screen.dart';
import 'package:trip_expenses_manager/widgets/form/navigator_button.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 80,
            // decoration: const BoxDecoration(color: Colors.red),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '여행자님, 안녕하세요',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '새로운 여행을 떠나볼까요?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return TripCard(trip: tripList[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: tripList.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const NavigatorButton(
        destinationScreen: TripFormScreen(formType: FormType.create),
        text: '새로운 여행 추가하기',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
