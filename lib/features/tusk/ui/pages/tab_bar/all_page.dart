
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/add_event_entity.dart';
import '../../widgets/event_widget.dart';

class AllTasksPage extends StatelessWidget {
  final  List<TuskEntity>? data;

  const AllTasksPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return   EventsWidget(data: data,);
  }
}