import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:second_task_todo_listapp/core/helper/spacing.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/enums/status_enum.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../tusks_cubit.dart';
import '../widgets/add_edit_listener.dart';

class AddAndEditEventPage extends StatefulWidget {
  final TaskEntity data;
  final bool isEdit;

  const AddAndEditEventPage({
    super.key,
    required this.data,
    this.isEdit = false,
  });

  @override
  State<AddAndEditEventPage> createState() => _AddAndEditEventPageState();
}

class _AddAndEditEventPageState extends State<AddAndEditEventPage> {
  final _titleTextController = TextEditingController();
  final _contextTextController = TextEditingController();

  final List<StatusEnum> _statuses = StatusEnum.values;
  StatusEnum _selectedStatus = StatusEnum.urgent;

  void _getInitialData() {
    _titleTextController.text = widget.data.title;
    _contextTextController.text = widget.data.eventContext;
    _selectedStatus = StatusEnum.values.firstWhere(
      (status) => status.localizer == widget.data.status,
      orElse: () => StatusEnum.urgent,
    );
  }

  @override
  void initState() {
    if (widget.isEdit) {
      _getInitialData();
    }
    super.initState();
  }

  final ValueNotifier<bool> _isValueNotifier = ValueNotifier(false);

  bool isDataChange() {
    if ((_titleTextController.text.isNotEmpty) &&
        (_contextTextController.text.isNotEmpty)) {
      _isValueNotifier.value = true;
    } else {
      _isValueNotifier.value = false;
    }
    return _isValueNotifier.value;
  }

  @override
  void dispose() {
    _contextTextController.dispose();
    _titleTextController.dispose();
    _isValueNotifier.dispose();
    super.dispose();
  }

  void _handleAddEventPress() {
    if (widget.isEdit) {
      _editEventTask();
    } else {
      _addEventTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddEditListener(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
          ),
          title: Text(
            widget.isEdit ? "Edit Event" : "Add Event",
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
                controller: _titleTextController,
                textHint: 'Enter Title',
                onChanged: (text) {
                  isDataChange();
                  setState(() {});
                },
              ),
              verticalSpace(20),
              AppTextField(
                label: 'Event Context',
                controller: _contextTextController,
                textHint: 'Enter Context',
                maxLines: 3,
                onChanged: (text) {
                  isDataChange();
                  setState(() {});
                },
              ),
              verticalSpace(50),
              DropdownButtonFormField<StatusEnum>(
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  hintText: 'select',
                  border: OutlineInputBorder(),
                  labelText: 'Select Status',
                ),
                value: _selectedStatus,
                items: _statuses.map((StatusEnum status) {
                  return DropdownMenuItem<StatusEnum>(
                    value: status,
                    child: Text(status.localizer), // Display the enum name
                  );
                }).toList(),
                onChanged: (StatusEnum? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: _isValueNotifier,
          builder: (context, value, child) {
            return FloatingActionButton(
              onPressed: value ? _handleAddEventPress : null,
              child: Icon(
                color: value ? Colors.green : Colors.red,
                widget.isEdit ? Icons.save : Icons.edit,
              ),
            );
          },
        ),
      ),
    );
  }

  void _addEventTask() {
    context.read<TusksCubit>().addEvent(
          TaskEntity(
            title: _titleTextController.text,
            eventContext: _contextTextController.text,
            date: DateFormat("E d MMM h:mm a").format(DateTime.now()),
            status: _selectedStatus.localizer,
          ),
        );
  }

  void _editEventTask() {
    final User? credential = FirebaseAuth.instance.currentUser;
    context.read<TusksCubit>().editEvent(
          input: TaskEntity(
              title: _titleTextController.text,
              eventContext: _contextTextController.text,
              date: DateFormat("E d MMM h:mm a").format(DateTime.now()),
              status: _selectedStatus.localizer,
              id: credential?.uid),
          collectionPath: credential!.uid,
        );
  }
}
