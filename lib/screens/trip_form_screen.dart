import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/types/form.dart';

import '../widgets/form/button.dart';
import '../widgets/form/text_field.dart';

class TripFormScreen extends StatelessWidget {
  final FormType formType;

  const TripFormScreen({
    super.key,
    required this.formType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("여행 ${formType == FormType.create ? '추가' : '수정'}하기"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Input(label: "여행 제목"),
            Input(label: "여행 기간"),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          Flexible(
            child: BasicButton(
              onPressed: () {},
              text: '취소',
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
