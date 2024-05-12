import 'package:flutter/material.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../widgets/listview_widget.dart';

class AllTasksPage extends StatelessWidget {
  final List<TaskEntity> data;
  final void Function(String) onDelete;

  const AllTasksPage({
    super.key,
    required this.data,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BuildListView(
      items: data,
      onDelete: onDelete,
    );
  }
}
