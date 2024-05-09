
import '../entities/add_event_entity.dart';
import '../repos/task_repository.dart';

class AddEventUseCase{
  final TusksRepository _eventRepository;

  AddEventUseCase(this._eventRepository);
  Future <void> call(TuskEntity input) async{
    return await _eventRepository.addEvent(input);
  }
}