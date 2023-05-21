import 'package:trip_expenses_manager/models/expense_category.dart';

class Expense {
  final String id, description;
  final int amount;
  final DateTime dateTime;
  final ExpenseCategory category;
  // final List<Image> images

  Expense({
    required this.id,
    required this.amount,
    required this.description,
    required this.dateTime,
    required this.category,
  });
}
