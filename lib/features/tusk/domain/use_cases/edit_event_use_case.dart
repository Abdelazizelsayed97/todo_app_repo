
import '../entities/add_event_entity.dart';
import '../repos/task_repository.dart';

class EditEventUseCase {
  final TusksRepository _eventRepository;

  EditEventUseCase(this._eventRepository);

  Future<void> execute({required TaskEntity input,required String collectionPath}) async {
    return await _eventRepository.editEvent(
        input: input, collectionPath: collectionPath);
  }
}
