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
  AddEventPage(
      {super.key, required this.pageTitle, this.data, this.id, this.editData});

  final String pageTitle;
  final List<TaskEntity>? data;
  final TaskEntity? editData;
  late String status;
  final String? id;

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final titleController = TextEditingController();
  final valueController = SingleValueDropDownController();

  final contextController = TextEditingController();

  @override
  void initState() {
    titleController.text =
        widget.pageTitle == 'Add Event' ? '' : widget.editData?.title ?? '';
    contextController.text = widget.pageTitle == 'Add Event'
        ? ''
        : widget.editData?.eventContext ?? '';

    widget.status =
        widget.pageTitle == 'Add Event' ? '' : widget.editData?.status ?? '';

    super.initState();
  }

  @override
  void dispose() {
    contextController.dispose();
    titleController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TusksCubit, TusksState>(
      listener: (context, state) {
        if (state is AddSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TasksPage()));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is EditSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TasksPage()));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child:
              Icon(widget.pageTitle == 'Add Event' ? Icons.save : Icons.edit),
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TasksPage()));
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
                onChanged: (value) {
                  if (widget.pageTitle == 'Add Event') {
                    print('this is context ${widget.editData?.eventContext}');
                    contextController.text =
                        widget.editData?.eventContext ?? '';
                    value = widget.editData?.eventContext ?? '';
                  }
                },
                label: 'Event Context',
                controller: contextController,
                textHint: 'Enter Context',
                maxLines: 3,
              ),
              verticalSpace(50),
              DropDownTextField(
                onChanged: (status) {
                  status = widget.status;
                  status = valueController.dropDownValue?.name;
                },
                controller: valueController,
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
        status: widget.status));
  }

  void _editTusk(String id) {
    context.read<TusksCubit>().editEvent(
          input: TaskEntity(
              title: titleController.text,
              eventContext: contextController.text,
              date: '2024',
              status: widget.status),
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
