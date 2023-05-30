import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/trip.dart';
import 'package:trip_expenses_manager/screens/expense_form_screen.dart';
import 'package:trip_expenses_manager/static/expense_list.dart';
import 'package:trip_expenses_manager/types/form.dart';
import 'package:trip_expenses_manager/widgets/form/navigator_button.dart';

import '../models/expense.dart';
import '../utils/formatter.dart';
import '../widgets/expense/day_bar.dart';

class ExpenseListScreen extends StatelessWidget {
  final Trip trip;
  int get tripPeriod => trip.getTripPeriod();

  const ExpenseListScreen({
    super.key,
    required this.trip,
  });

  List<Expense> filterExpensesByDay({
    required int day,
    required DateTime startDate,
    required int period,
    required List<Expense> expenses,
  }) {
    if (day == 0) {
      return expenses
          .where((expense) => expense.dateTime.isBefore(startDate))
          .toList();
    }
    if (day == period + 1) {
      DateTime endDate = startDate.add(Duration(days: period));
      return expenses
          .where((expense) => expense.dateTime.isAfter(endDate))
          .toList();
    }

    DateTime currentDate = startDate.add(Duration(days: day));
    return expenses
        .where((expense) => expense.dateTime.isAtSameMomentAs(currentDate))
        .toList();
  }

  int getTotalAmount(List<Expense> expenses) {
    return expenses.fold(
        0, (totalAmount, current) => totalAmount + current.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${trip.title} 비용"),
      ),
      body: Column(
        children: [
          Text('총 ${formatNumberWithSeparator(getTotalAmount(expenses))} 원'),
          for (var day = 0; day < tripPeriod + 2; day++)
            Row(
              children: [
                DayBar(
                  currentDay: day,
                  period: tripPeriod,
                  startDate: trip.startDate,
                  totalAmount: getTotalAmount(filterExpensesByDay(
                      day: day,
                      startDate: trip.startDate,
                      period: tripPeriod,
                      expenses: expenses)),
                ),
                // ListView(
                //   children: [
                //     for (var expense in filterExpensesByDay(
                //       day: day,
                //       startDate: trip.startDate,
                //       period: tripPeriod,
                //       expenses: expenses,
                //     ))
                //       ExpenseItem(expense: expense)
                //   ],
                // ),
              ],
            )
        ],
      ),
      floatingActionButton: const NavigatorButton(
        destinationScreen: ExpenseFormScreen(formType: FormType.create),
        text: '여행 경비 추가하기',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
