import 'package:flutter/material.dart';
import 'package:trip_expenses_manager/screens/trip_list_screen.dart';
import 'package:trip_expenses_manager/types/form.dart';

import '../widgets/form/button.dart';
import '../widgets/form/text_field.dart';

class TripFormScreen extends StatefulWidget {
  final FormType formType;

  const TripFormScreen({
    super.key,
    required this.formType,
  });

  @override
  State<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  final formKey = GlobalKey<FormState>();
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("여행 ${widget.formType == FormType.create ? '추가' : '수정'}하기"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Input(
                label: "여행 제목",
                onSaved: (val) {
                  setState(() {
                    title = val;
                  });
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '이름은 필수사항입니다.';
                  }
                  return null;
                },
              ),
              Input(
                label: "여행 기간",
                onSaved: (val) {},
                validator: (val) {
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Flexible(
            child: BasicButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TripListScreen(),
                  ),
                );
              },
              text: '취소',
              backgroundColor: Colors.black12,
            ),
          ),
          Flexible(
            child: BasicButton(
              onPressed: () {
                if (formKey.currentState != null &&
                    formKey.currentState!.validate() == true) {}
              },
              text: '확인',
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
