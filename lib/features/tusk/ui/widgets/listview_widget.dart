import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/add_event_entity.dart';
import 'dismethable_widget.dart';
import 'event_card_body.dart';

class BuildListView extends StatelessWidget {
  final List<TaskEntity> items;
  final void Function(String) onDelete;

  const BuildListView({
    super.key,
    required this.items,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return DismissibleListItem(
          onDelete: () => onDelete(items[index].id ?? ''),
          child: EventCardBody(
            input: items[index],
            title: items[index].title ?? "",
            eventContext: items[index].eventContext ?? "",
            status: items[index].status ?? "",
            date: items[index].date ?? '',
            id: items[index].id ?? '',
          ),
        );
      },
    );
  }
}
