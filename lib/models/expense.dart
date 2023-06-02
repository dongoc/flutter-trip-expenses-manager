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

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tripId = json['trip_id'],
        description = json['description'],
        amount = json['amount'],
        dateTime = json['date_time'],
        category = json['category'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trip_id': tripId,
      'description': description,
      'amount': amount,
      'date_time': dateTime.toIso8601String(),
      'category': category,
    };
  }
}
