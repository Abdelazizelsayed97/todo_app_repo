import '../repos/add_event_repository.dart';

class AddEventUseCase{
  final TusksRepository _eventRepository;

  AddEventUseCase(this._eventRepository);
  Future <void> call(AddEventEntity input) async{
    return await _eventRepository.addEvent(input);
  }
}