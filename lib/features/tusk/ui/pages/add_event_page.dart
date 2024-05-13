import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:second_task_todo_listapp/core/helper/spacing.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/main_tasks_page.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/enums/status_enum.dart';
import '../tusks_cubit.dart';



class AddEventPage extends StatefulWidget {
  AddEventPage(
      {super.key, required this.pageTitle, this.data, this.id, this.editData});

  final String pageTitle;
  final List<TaskEntity>? data;
  final TaskEntity? editData;
  final String? id;
  final dateFormat = DateTime.now();

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final titleController = TextEditingController();
  SingleValueDropDownController valueController =
      SingleValueDropDownController();

  final contextController = TextEditingController();

  @override
  void initState() {
    titleController.text =
        widget.pageTitle == 'Add Event' ? '' : widget.editData?.title ?? '';
    contextController.text = widget.pageTitle == 'Add Event'
        ? ''
        : widget.editData?.eventContext ?? '';
    valueController.setDropDown(DropDownValueModel(
        name: widget.editData?.status ?? '', value: widget.editData?.status));

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
              MaterialPageRoute(builder: (context) => const MainTasksPage()));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is EditSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainTasksPage()));
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
                  MaterialPageRoute(builder: (context) => const MainTasksPage()));
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
                maxLines: 3,
              ),
              verticalSpace(50),
              DropDownTextField(
                controller: valueController,
                dropDownList: [
                  DropDownValueModel(
                      name: StatusEnum.urgent.localizer,
                      value: StatusEnum.values[0].localizer),
                  DropDownValueModel(
                      name: StatusEnum.completed.localizer,
                      value: StatusEnum.values[1].localizer),
                  DropDownValueModel(
                      name: StatusEnum.uncompleted.localizer,
                      value: StatusEnum.values[2].localizer)
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
        date: DateFormat("E d MMM h:mm a").format(widget.dateFormat),
        status: valueController.dropDownValue?.name ?? ""));
  }

  void _editTusk(String id) {
    context.read<TusksCubit>().editEvent(
          input: TaskEntity(
              title: titleController.text,
              eventContext: contextController.text,
              date: widget.dateFormat.toString(),
              status: valueController.dropDownValue?.name ?? ""),
          collectionPath: id,
        );
  }
}

