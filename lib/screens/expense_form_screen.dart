import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip_expenses_manager/models/expense.dart';
import 'package:trip_expenses_manager/screens/expense_list_screen.dart';

import '../db/sqflite.dart';
import '../models/expense_category.dart';
import '../models/expense_form.dart';
import '../models/trip.dart';
import '../static/expense_categories.dart';
import '../types/form.dart';
import '../widgets/form/button.dart';
import '../widgets/form/text_field.dart';

class ExpenseFormScreen extends StatefulWidget {
  final FormType formType;
  final Expense? expense;
  final Trip trip;

  const ExpenseFormScreen({
    super.key,
    required this.formType,
    required this.trip,
    this.expense,
  });

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final TripDatabase _tripDatabase = TripDatabase();
  int amount = 0;
  String description = '';
  DateTime dateTime = DateTime.now();
  ExpenseCategoryKey currentCategoryKey = ExpenseCategoryKey.etc;

  Future<void> onCreateExpense() async {
    if (amount > 0 && description != '') {
      await _tripDatabase.createExpense(ExpenseForm(
        tripId: widget.trip.id,
        amount: amount,
        description: description,
        dateTime: dateTime,
        category: currentCategoryKey,
      ));

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpenseListScreen(
            trip: widget.trip,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("비용 ${widget.formType == FormType.create ? "추가" : "수정"}하기"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Input(
                type: TextInputType.number,
                label: "지출 금액",
                onSaved: (val) {},
                validator: (val) {
                  return null;
                },
              ),
              Input(
                label: "지출 내역",
                onSaved: (val) {},
                validator: (val) {
                  return null;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '카테고리',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (ExpenseCategory category in categories.values)
                    ListTile(
                      title: Text(category.label),
                      leading: Radio<ExpenseCategoryKey>(
                        value: category.key,
                        groupValue: currentCategoryKey,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              currentCategoryKey = value;
                            }
                          });
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '날짜',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      formatDate(dateTime, [yyyy, '년 ', mm, '월 ', dd, '일']),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
              TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                currentDay: dateTime,
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  setState(() {
                    dateTime = selectedDay;
                  });
                },
              ),
              TextButton(onPressed: () {}, child: const Text('사진 추가'))
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Flexible(
            child: BasicButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: '취소',
              backgroundColor: Colors.black26,
            ),
          ),
          Flexible(
            child: BasicButton(
              onPressed: () {},
              text: '확인',
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
