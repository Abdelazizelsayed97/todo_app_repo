import '../repos/task_repository.dart';

class DeleteEventUseCase{
  final TusksRepository _eventRepository;

  DeleteEventUseCase(this._eventRepository);
  Future <void> execute(String id) async{
    return await _eventRepository.deleteEvent(id);
  }
}