import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/trip.dart';
import 'package:trip_expenses_manager/screens/expense_form_screen.dart';
import 'package:trip_expenses_manager/types/form.dart';
import 'package:trip_expenses_manager/widgets/expense/expense_item.dart';
import 'package:trip_expenses_manager/widgets/form/navigator_button.dart';

import '../db/sqflite.dart';
import '../models/expense.dart';
import '../static/expense_list.dart';
import '../utils/formatter.dart';

class ExpenseListScreen extends StatefulWidget {
  final Trip trip;
  const ExpenseListScreen({
    super.key,
    required this.trip,
  });

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  int get tripPeriod => widget.trip.getTripPeriod();
  late List<Expense> expenseList = [];
  final TripDatabase _tripDatabase = TripDatabase();

  Future _getExpenseList() async {
    expenseList = await _tripDatabase.getExpenseList(widget.trip.id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getExpenseList();
  }

  // Future<List<Expense>> expenses
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
        title: Text("${widget.trip.title} 비용"),
      ),
      body: Column(
        children: [
          Text('총 ${formatNumberWithSeparator(getTotalAmount(expenses))} 원'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ExpenseItem(
                      expense: expenseList[index], trip: widget.trip);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: expenseList.length,
              ),
            ),
          ),
        ],
      ),
      // FutureBuilder(
      // future:
      // builder: (), {},)
      // for (var day = 0; day < tripPeriod + 2; day++)
      //   Row(
      //     children: [
      //       DayBar(
      //         currentDay: day,
      //         period: tripPeriod,
      //         startDate: trip.startDate,
      //         totalAmount: getTotalAmount(filterExpensesByDay(
      //             day: day,
      //             startDate: trip.startDate,
      //             period: tripPeriod,
      //             expenses: expenses)),
      //       ),
      //       // ListView(
      //       //   children: [
      //       //     for (var expense in filterExpensesByDay(
      //       //       day: day,
      //       //       startDate: trip.startDate,
      //       //       period: tripPeriod,
      //       //       expenses: expenses,
      //       //     ))
      //       //       ExpenseItem(expense: expense)
      //       //   ],
      //       // ),
      //     ],
      //   )
      floatingActionButton: NavigatorButton(
        destinationScreen: ExpenseFormScreen(
          formType: FormType.create,
          trip: widget.trip,
        ),
        text: '여행 경비 추가하기',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
