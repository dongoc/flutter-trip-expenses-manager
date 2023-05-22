import 'package:trip_expenses_manager/models/expense_category.dart';

class Expense {
  final int id, tripId;
  final String description;
  final int amount;
  final DateTime dateTime;
  final ExpenseCategoryKey category;
  // final List<Image> images

  Expense({
    required this.id,
    required this.tripId,
    required this.amount,
    required this.description,
    required this.dateTime,
    required this.category,
  });
}
