import 'dart:async';


import '../entities/add_event_entity.dart';
import '../repos/task_repository.dart';

class GetEventUseCase {
  final TusksRepository _eventRepository;

  GetEventUseCase(this._eventRepository);

  Stream<List<TaskEntity>> call() {
    return _eventRepository.getTasks();
  }
}
