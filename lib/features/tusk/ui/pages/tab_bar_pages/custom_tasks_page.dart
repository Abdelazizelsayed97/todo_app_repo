import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/enums/status_enum.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/tusks_cubit.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/dismethable_widget.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/event_card_body.dart';

import '../../../domain/entities/add_event_entity.dart';

class CustomTasksPage extends StatefulWidget {
  final List<TaskEntity>? data;
  final StatusEnum? selectStatusEnum;

  const CustomTasksPage({
    super.key,
    this.data,
    required this.selectStatusEnum,
  });

  @override
  State<CustomTasksPage> createState() => _CustomTasksPageState();
}

class _CustomTasksPageState extends State<CustomTasksPage> {
  Future<void> _deleteItem({
    required BuildContext context,
    required String documentId,
  }) async {
    BlocProvider.of<TusksCubit>(context).deleteEvent(documentId);
  }

  List<TaskEntity>? filteredList = [];

  List<TaskEntity>? _filterData() {
    if (widget.selectStatusEnum == null) {
      return widget.data;
    } else {
      return widget.data
          ?.where(
              (element) => element.status == widget.selectStatusEnum?.localizer)
          .toList();
    }
  }

  String _getEmptyData(StatusEnum? type) {
    switch (type) {
      case StatusEnum.uncompleted:
        return "Uncompleted";
      case StatusEnum.completed:
        return "Completed";
      case StatusEnum.urgent:
        return "Urgent";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    filteredList = _filterData();
    return (filteredList?.isEmpty ?? false)
        ? Center(
            child: Text(
              widget.selectStatusEnum?.localizer == null
                  ? 'No Data Found'
                  : "No Data Found in ${_getEmptyData(widget.selectStatusEnum)} add one ",
              style: Styles.bold(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          )
        : ListView.builder(
            itemCount: filteredList?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final documentId = filteredList?[index].id;
              final item = filteredList?[index];
              return DismissibleListItem(
                onDelete: () {
                  _deleteItem(
                      context: context, documentId: documentId.toString());
                },
                child: EventCardBody(
                  input: item,
                  title: item?.title ?? "",
                  eventContext: item?.eventContext ?? "",
                  status: item?.status ?? "",
                  date: item?.date ?? '',
                  id: item?.id ?? '',
                ),
              );
            },
          );
  }
}
