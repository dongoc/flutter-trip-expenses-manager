import 'package:trip_expenses_manager/models/expense_category.dart';

class ExpenseForm {
  final int tripId;
  final String description;
  final int amount;
  final DateTime dateTime;
  final ExpenseCategoryKey category;
  // final List<Image> images

  ExpenseForm({
    required this.tripId,
    required this.amount,
    required this.description,
    required this.dateTime,
    required this.category,
  });

  ExpenseForm.fromJson(Map<String, dynamic> json)
      : tripId = json['trip_id'],
        description = json['description'],
        amount = json['amount'],
        dateTime = json['date_time'],
        category = json['category'];

  Map<String, dynamic> toMap() {
    return {
      'trip_id': tripId,
      'description': description,
      'amount': amount,
      'date_time': dateTime.toIso8601String(),
      'category': category.toString(),
    };
  }
}
