import 'package:flutter/material.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/add_event_entity.dart';

import 'event_card_body.dart';

class EventsWidget extends StatefulWidget {
  final  List<TuskEntity>?  data;

  const EventsWidget({super.key,  this.data});

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data?.length??0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return  EventCardBody(index: index,
        data:widget.data??[] ,
        );
      },
    );
  }
}
