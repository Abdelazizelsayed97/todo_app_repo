import 'package:flutter/material.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../widgets/listview_widget.dart';

class CompletedTasksPage extends StatelessWidget {
  const CompletedTasksPage({super.key, this.data, required this.onDelete});

  final List<TaskEntity>? data;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    List<TaskEntity>? newList = [];

    newList = data?.where((element) => element.status == "completed").toList();

    return BuildListView(
      items: newList ?? [],
      onDelete: onDelete,
    );
  }
}
