import '../entities/add_event_entity.dart';

abstract class TusksRepository {
  Future<void> addEvent(AddEventEntity input);

  Future <void> deleteEvent();

  Future <void> editEvent();
  Future <List<AddEventEntity>> getEvent();
}
