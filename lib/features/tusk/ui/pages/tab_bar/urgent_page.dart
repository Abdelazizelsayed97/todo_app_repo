import 'package:flutter/material.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../widgets/event_widget.dart';

class UrgentTasksPage extends StatelessWidget {
  final List<TuskEntity>? data;
  final List<TuskEntity>? type = [];


   UrgentTasksPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
if(data!.contains('urgent')){
  type?.addAll(data as Iterable<TuskEntity>) ;
}

      return EventsWidget(
        data: data.where((element) => element )?? [],
      );

  }
}
