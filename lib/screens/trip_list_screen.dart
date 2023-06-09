import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/db/sqflite.dart';
import 'package:trip_expenses_manager/screens/trip_form_screen.dart';
import 'package:trip_expenses_manager/widgets/form/navigator_button.dart';

// import '../static/trip_list.dart';
import '../models/trip.dart';
import '../types/form.dart';
import '../widgets/trip/trip_card.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({super.key});

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  late List<Trip> tripList = [];
  final TripDatabase _tripDatabase = TripDatabase();

  Future _getTripList() async {
    tripList = await _tripDatabase.getTripList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getTripList(); // 비동기라서 못그릴 수도??
  }

  @override
  Widget build(BuildContext context) {
    // async -> await (Future Builder)
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
