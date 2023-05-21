import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/trip.dart';
import 'package:trip_expenses_manager/screens/expense_form_screen.dart';
import 'package:trip_expenses_manager/types/form.dart';

class ExpenseListScreen extends StatelessWidget {
  final Trip trip;

  const ExpenseListScreen({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${trip.title} 비용"),
      ),
      body: const Card(
        child: Text('비용 카드'),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ExpenseFormScreen(formType: FormType.create)));
        },
        style: const ButtonStyle(),
        child: const Text('여행 목록'),
      ),
    );
  }
}
