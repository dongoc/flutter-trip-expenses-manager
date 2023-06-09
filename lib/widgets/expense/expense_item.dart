import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/expense.dart';
import 'package:trip_expenses_manager/screens/expense_form_screen.dart';
import 'package:trip_expenses_manager/static/expense_categories.dart';

import '../../models/trip.dart';
import '../../types/form.dart';
import '../../utils/formatter.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final Trip trip;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExpenseFormScreen(
                formType: FormType.update,
                expense: expense,
                trip: trip,
              ),
            ));
      },
      child: Row(
        children: [
          Text(formatDate(expense.dateTime, [hh, ":", nn])),
          Column(
            children: [
              Icon(categories[expense.category]!.icon),
              Text(expense.description),
              Text('${formatNumberWithSeparator(expense.amount)} 원')
            ],
          )
        ],
      ),
    );
  }
}
