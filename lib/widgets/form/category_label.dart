import 'package:flutter/material.dart';

import '../../models/expense_category.dart';

class CategoryLabel extends StatelessWidget {
  final ExpenseCategory category;

  const CategoryLabel({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Text(category.label);
  }
}
