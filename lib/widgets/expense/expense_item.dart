import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/expense.dart';
import 'package:trip_expenses_manager/screens/expense_form_screen.dart';
import 'package:trip_expenses_manager/static/expense_categories.dart';

import '../../types/form.dart';
import '../../utils/formatter.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({
    super.key,
    required this.expense,
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
