import 'dart:async';


import '../entities/add_event_entity.dart';

abstract class TusksRepository {
  Future<void> addEvent(TaskEntity input);

  Future<void> deleteEvent(String id);

  Future<void> editEvent({TaskEntity? input, String? collectionPath});

  Stream<List<TaskEntity>> getTasks();
}
