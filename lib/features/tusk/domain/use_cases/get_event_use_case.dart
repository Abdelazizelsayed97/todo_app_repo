import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/add_event_entity.dart';
import '../repos/task_repository.dart';

class GetEventUseCase {
  final TusksRepository _eventRepository;

  GetEventUseCase(this._eventRepository);

  Stream<List<TuskEntity>> call() {
    return _eventRepository.getTasks();
  }
}
