import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/expense_category.dart';

List<ExpenseCategory> categories = [
  ExpenseCategory(
    key: ExpenseCategoryKey.hotel,
    label: '숙소',
    icon: Icons.house,
  ),
  ExpenseCategory(
    key: ExpenseCategoryKey.air,
    label: '항공',
    icon: Icons.airplanemode_active,
  ),
  ExpenseCategory(
    key: ExpenseCategoryKey.traffic,
    label: '교통',
    icon: Icons.train,
  ),
  ExpenseCategory(
    key: ExpenseCategoryKey.food,
    label: '식비',
    icon: Icons.coffee,
  ),
  ExpenseCategory(
    key: ExpenseCategoryKey.shopping,
    label: '쇼핑',
    icon: Icons.house,
  ),
  ExpenseCategory(
    key: ExpenseCategoryKey.tour,
    label: '관광',
    icon: Icons.attractions,
  ),
  ExpenseCategory(
    key: ExpenseCategoryKey.etc,
    label: '기타',
    icon: Icons.more_horiz,
  ),
];
