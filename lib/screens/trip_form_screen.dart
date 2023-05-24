import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/types/form.dart';

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
      body: const Column(
        children: [
          Input(label: "여행 제목"),
          Input(label: "여행 기간"),
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {},
        style: const ButtonStyle(),
        child: const Text('확인'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
