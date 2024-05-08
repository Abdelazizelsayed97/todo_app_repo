import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/repos/add_event_repository.dart';

class GetEventUseCase {
  final TusksRepository _eventRepository;

  GetEventUseCase(this._eventRepository);

  Stream<List<QueryDocumentSnapshot<TuskEntity>>> call() {
    return _eventRepository.getEvent();
  }
}
