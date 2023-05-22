import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/expense_category.dart';

Map<ExpenseCategoryKey, ExpenseCategory> categories = {
  ExpenseCategoryKey.hotel: ExpenseCategory(
    key: ExpenseCategoryKey.hotel,
    label: '숙소',
    icon: Icons.house,
  ),
  ExpenseCategoryKey.air: ExpenseCategory(
    key: ExpenseCategoryKey.air,
    label: '항공',
    icon: Icons.airplanemode_active,
  ),
  ExpenseCategoryKey.traffic: ExpenseCategory(
    key: ExpenseCategoryKey.traffic,
    label: '교통',
    icon: Icons.train,
  ),
  ExpenseCategoryKey.food: ExpenseCategory(
    key: ExpenseCategoryKey.food,
    label: '식비',
    icon: Icons.coffee,
  ),
  ExpenseCategoryKey.shopping: ExpenseCategory(
    key: ExpenseCategoryKey.shopping,
    label: '쇼핑',
    icon: Icons.house,
  ),
  ExpenseCategoryKey.tour: ExpenseCategory(
    key: ExpenseCategoryKey.tour,
    label: '관광',
    icon: Icons.attractions,
  ),
  ExpenseCategoryKey.etc: ExpenseCategory(
    key: ExpenseCategoryKey.etc,
    label: '기타',
    icon: Icons.more_horiz,
  ),
};
