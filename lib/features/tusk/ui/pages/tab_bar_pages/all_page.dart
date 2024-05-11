import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tusks_page.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/tusks_cubit.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/dismethable_widget.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/widgets/event_card_body.dart';

import '../../../domain/entities/add_event_entity.dart';

class AllTasksPage extends StatefulWidget {
  final List<TaskEntity>? data;

  const AllTasksPage({super.key, required this.data});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return BlocListener<TusksCubit, TusksState>(
          listener: (context, state) {
            if (state is DeleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('deleted'),
                ),
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const TusksPage()));
            }
          },
          child: DismissibleListItem(
            onDelete: () {
              setState(() {
                context.read<TusksCubit>().deleteEvent(
                    widget.data?[index].id);
              });
              setState(() {});
            },
            child: EventCardBody(
              title: widget.data?[index].title ?? "",
              eventContext: widget.data?[index].title ?? "",
              status: widget.data?[index].title ?? "",
              date: widget.data?[index].title ?? '',
              id: widget.data?[index].id ?? '',
            ),
          ),
        );
      },
    );
  }
}
