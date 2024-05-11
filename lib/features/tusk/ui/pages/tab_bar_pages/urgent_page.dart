import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/dismethable_widget.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../tusks_cubit.dart';
import '../../widgets/event_card_body.dart';

class UrgentTasksPage extends StatefulWidget {
  final List<TaskEntity>? data;

  const UrgentTasksPage({super.key, this.data});

  @override
  State<UrgentTasksPage> createState() => _UrgentTasksPageState();
}

class _UrgentTasksPageState extends State<UrgentTasksPage> {
  final List<TaskEntity>? type = [];

  @override
  Widget build(BuildContext context) {
    List<TaskEntity>? newList = [];

    newList =
        widget.data?.where((element) => element.status == "urgent").toList();

    return ListView.builder(
        itemCount: newList?.length,
        itemBuilder: (BuildContext context, int index) {
          return DismissibleListItem(
            onDelete: () {
              context.read<TusksCubit>().deleteEvent(widget.data?[index].id);
            },
            child: EventCardBody(
              id: widget.data?[index].id??'',
              title: newList?[index].title ?? '',
              eventContext: newList?[index].eventContext ?? '',
              status: newList?[index].status ?? "",
              date: newList?[index].date ?? '',
            ),
          );
        });
  }
}
