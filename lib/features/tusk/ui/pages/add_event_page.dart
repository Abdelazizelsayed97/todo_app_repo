import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/helper/spacing.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tusks_page.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../tusks_cubit.dart';

enum StatusEnum { uncompleted, completed, urgent }

const int index = 0;

class AddEventPage extends StatefulWidget {
  AddEventPage({super.key, required this.pageTitle, this.data, this.id});

  final String pageTitle;
  final List<TaskEntity>? data;

  final String? id;

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final titleController = TextEditingController();
  final valueController = SingleValueDropDownController();

  final contextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TusksCubit, TusksState>(
      listener: (context, state) {
        if (state is AddSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TusksPage()));
        }
        if (state is EditSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TusksPage()));
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(widget.pageTitle == 'Add Event'? Icons.save: Icons.edit),
          onPressed: () {
            if (widget.pageTitle == 'Add Event') {
              _addTusk();
            } else {
              _editTusk(widget.id ?? '');
            }
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TusksPage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
          ),
          title: Text(
            widget.pageTitle,
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
                controller: valueController,
                onChanged: (value) {
                  print('>>>>>>>>>>${valueController.dropDownValue?.name}');
                },
                dropDownList: [
                  DropDownValueModel(
                      name: StatusEnum.urgent.localize,
                      value: StatusEnum.values[0].localize),
                  DropDownValueModel(
                      name: StatusEnum.completed.localize,
                      value: StatusEnum.values[1].localize),
                  DropDownValueModel(
                      name: StatusEnum.uncompleted.localize,
                      value: StatusEnum.values[2].localize)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTusk() {
    context.read<TusksCubit>().addEvent(TaskEntity(
        title: titleController.text,
        eventContext: contextController.text,
        date: '2024',
        status: valueController.dropDownValue!.name));
  }

  void _editTusk(String id) {
    context.read<TusksCubit>().editEvent(
          input: TaskEntity(
              title: titleController.text,
              eventContext: contextController.text,
              date: '2024',
              status: valueController.dropDownValue!.name),
          collectionPath: id,
        );
  }
}

extension ConvertEnumToString on StatusEnum {
  String get localize {
    switch (this) {
      case StatusEnum.uncompleted:
        return 'uncompleted';
      case StatusEnum.completed:
        return 'completed';
      case StatusEnum.urgent:
        return 'urgent';
    }
  }
}
