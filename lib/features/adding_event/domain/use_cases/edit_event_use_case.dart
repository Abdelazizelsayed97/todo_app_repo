import 'package:second_task_todo_listapp/features/adding_event/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/repos/add_event_repository.dart';

class EditEventUseCase {
  final TusksRepository _eventRepository;

  EditEventUseCase(this._eventRepository);

  Future<void> call(TuskEntity input, String collectionPath) async {
    return await _eventRepository.editEvent(
        input: input, collectionPath: collectionPath);
  }
}
