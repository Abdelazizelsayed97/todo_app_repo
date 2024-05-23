import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/enums/status_enum.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/dismethable_widget.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/event_card_body.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../tusks_cubit.dart';

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

  List<TaskEntity> _sortData(List<TaskEntity> data) {
    data.sort((a, b) {
      if (a.status == StatusEnum.urgent.localizer) {
        return -1;
      } else if (a.status == StatusEnum.uncompleted.localizer &&
          b.status == StatusEnum.completed.localizer) {
        return -1;
      } else {
        return 1;
      }
    });
    return data;
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
    List<TaskEntity>? filteredList = _filterData();
    List<TaskEntity> sortedFilteredList = _sortData(filteredList ?? []);

    return (sortedFilteredList.isEmpty)
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
            itemCount: sortedFilteredList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final documentId = sortedFilteredList[index].id;
              final item = sortedFilteredList[index];
              return DismissibleListItem(
                onDelete: () =>
                    _deleteItem(context: context, documentId: documentId ?? ''),
                child: EventCardBody(
                  input: item,
                  title: item.title,
                  eventContext: item.eventContext,
                  status: item.status,
                  date: item.date ?? '',
                  id: item.id ?? '',
                ),
              );
            },
          );
  }
}
