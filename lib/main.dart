import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/screens/trip_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '시니어 여행가계부',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(56, 96, 255, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(56, 96, 255, 1),
        ),
      ),
      home: const TripListScreen(),
    );
  }
}
