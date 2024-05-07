import 'package:second_task_todo_listapp/features/adding_event/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/repos/add_event_repository.dart';

class AddEventUseCase{
  final TusksRepository _eventRepository;

  AddEventUseCase(this._eventRepository);
  Future <void> call(AddEventEntity input) async{
    return await _eventRepository.addEvent(input);
  }
}