import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip_expenses_manager/models/trip_form.dart';
import 'package:trip_expenses_manager/screens/trip_list_screen.dart';
import 'package:trip_expenses_manager/types/form.dart';
import 'package:trip_expenses_manager/utils/formatter.dart';

import '../db/sqflite.dart';
import '../models/trip.dart';
import '../widgets/form/button.dart';
import '../widgets/form/text_field.dart';

class TripFormScreen extends StatefulWidget {
  final FormType formType;
  final Trip? initialTrip;

  const TripFormScreen({
    super.key,
    required this.formType,
    this.initialTrip,
  });

  @override
  State<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  final TripDatabase _tripDatabase = TripDatabase();
  final formKey = GlobalKey<FormState>();
  int? id;
  String title = '';
  DateTime? startDate, endDate;
  FormType formType = FormType.create;

  @override
  void initState() {
    super.initState();
    setState(() {
      id = widget.initialTrip?.id;
      title = widget.initialTrip != null ? widget.initialTrip!.title : '';
      startDate = widget.initialTrip?.startDate;
      endDate = widget.initialTrip?.endDate;
      formType = widget.formType;
    });
  }

  Future<void> onCreateTrip() async {
    if (title != '' && startDate != null) {
      await _tripDatabase.createTrip(TripForm(
        title: title,
        startDate: startDate!,
        endDate: endDate,
      ));

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TripListScreen(),
        ),
      );
    }
  }

  Future<void> onUpdateTrip() async {
    await _tripDatabase.updateTrip(Trip(
      id: id!,
      title: title,
      startDate: startDate!,
      endDate: endDate,
    ));

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TripListScreen(),
      ),
    );
  }

  Future<void> onDeleteTrip() async {
    if (id != null) {
      await _tripDatabase.deleteTrip(id!);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TripListScreen(),
        ),
      );
    }
    return;
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Input(
                label: "여행 제목",
                // initialValue: formType == FormType.update
                //     ? TripFormScreen.initialTrip!.title
                //     : null,
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
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '여행 기간',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      startDate != null
                          ? getPeriodText(startDate!, endDate)
                          : '여행 기간을 선택하세요',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
              TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                onRangeSelected: (start, end, focused) {
                  setState(() {
                    startDate = start;
                    endDate = end;
                  });
                },
                rangeStartDay: startDate,
                rangeEndDay: endDate,
              ),
              const SizedBox(
                height: 20,
              ),
              formType == FormType.update
                  ? TextButton(
                      onPressed: onDeleteTrip,
                      child: const Text(
                        '여행 삭제하기',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : const SizedBox(
                      height: 20,
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Flexible(
            child: BasicButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: '취소',
              backgroundColor: Colors.black26,
            ),
          ),
          Flexible(
            child: BasicButton(
              disabled: !(title != '' && startDate != null),
              onPressed: () {
                formType == FormType.create ? onCreateTrip() : onUpdateTrip();
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
