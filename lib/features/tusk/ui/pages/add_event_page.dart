import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/helper/spacing.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';

import '../../../../core/widgets/app_text_field.dart';

enum StatusEnum { all, uncompleted, completed, urgent }

const int index = 0;
const String status = '';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final titleController = TextEditingController();

  final contextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_outlined,
          size: 30,
        ),
        title: Text(
          'Add Event',
          style: Styles.bold(fontSize: 22, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            verticalSpace(20),
            AppTextField(
              label: 'Event Title',
              controller: titleController,
              textHint: 'Enter Title',
            ),
            verticalSpace(20),
            AppTextField(
              label: 'Event Context',
              controller: contextController,
              textHint: 'Enter Context',
            ),
            verticalSpace(50),
            DropDownTextField(
                initialValue: xx.first,
                onChanged: (status) {
                  DropDownValueModel x = status as DropDownValueModel;
                  value = x.name;
                  print('value ===>${value}');
                },
                dropDownList: xx),
          ],
        ),
      ),
    );
  }

  String value = StatusEnum.all.localize;

  final xx = [
    DropDownValueModel(
        name: StatusEnum.all.localize,
        value: StatusEnum.values[index].localize),
    DropDownValueModel(
        name: StatusEnum.completed.localize,
        value: StatusEnum.values[index].localize),
    DropDownValueModel(
        name: StatusEnum.uncompleted.localize,
        value: StatusEnum.values[index].localize)
  ];

  void _addTusk() {}
}

extension ConvertEnumToString on StatusEnum {
  String get localize {
    switch (this) {
      case StatusEnum.all:
        return 'All';
      case StatusEnum.uncompleted:
        return 'Uncompleted';
      case StatusEnum.completed:
        return 'Completed';
      case StatusEnum.urgent:
        return 'Urgent';
    }
  }
}
