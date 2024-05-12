import 'package:flutter/material.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../widgets/listview_widget.dart';

class UrgentTasksPage extends StatelessWidget {
  final List<TaskEntity>? data;
  final void Function(String) onDelete;

  UrgentTasksPage({super.key, this.data, required this.onDelete});

  final List<TaskEntity>? type = [];

  @override
  Widget build(BuildContext context) {
    List<TaskEntity>? newList = [];

    newList = data?.where((element) => element.status == "urgent").toList();

    return BuildListView(
      items: newList ?? [],
      onDelete: onDelete,
    );
  }
}
