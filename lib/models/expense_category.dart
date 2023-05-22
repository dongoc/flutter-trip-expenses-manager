import 'package:flutter/material.dart';

enum ExpenseCategoryKey {
  hotel,
  air,
  traffic,
  food,
  shopping,
  tour,
  etc,
}

class ExpenseCategory {
  final ExpenseCategoryKey key;
  final String label;
  final IconData icon;

  ExpenseCategory({
    required this.key,
    required this.label,
    required this.icon,
  });
}
