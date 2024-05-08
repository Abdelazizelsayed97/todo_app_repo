import '../entities/add_event_entity.dart';
import '../repos/add_event_repository.dart';

class DeleteEventUseCase{
  final TusksRepository _eventRepository;

  DeleteEventUseCase(this._eventRepository);
  Future <void> call(String? id) async{
    return await _eventRepository.deleteEvent( id);
  }
}