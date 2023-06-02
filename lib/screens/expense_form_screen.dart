import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/models/expense.dart';

import '../types/form.dart';
import '../widgets/form/text_field.dart';

class ExpenseFormScreen extends StatelessWidget {
  final FormType formType;
  final Expense? expense;

  const ExpenseFormScreen({
    super.key,
    required this.formType,
    this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("비용 ${formType == FormType.create ? "추가" : "수정"}하기"),
      ),
      body: Column(
        children: [
          Input(
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
              }),
          Input(
            label: "카테고리",
            onSaved: (val) {},
            validator: (val) {
              return null;
            },
          ),
          Input(
            label: "날짜 / 시간",
            onSaved: (val) {},
            validator: (val) {
              return null;
            },
          ),
          TextButton(onPressed: () {}, child: const Text('사진 추가'))
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {},
        style: const ButtonStyle(),
        child: const Text('추가'),
      ),
    );
  }
}
