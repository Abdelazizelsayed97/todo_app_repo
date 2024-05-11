import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/dismethable_widget.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../tusks_cubit.dart';
import '../../widgets/event_card_body.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key, this.data});

  final List<TaskEntity>? data;

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  @override
  Widget build(BuildContext context) {
    List<TaskEntity>? newList = [];

    newList =
        widget.data?.where((element) => element.status == "completed").toList();

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
