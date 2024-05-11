import '../domain/entities/add_event_entity.dart';
import 'models/tusk_model.dart';


extension ConvertTuskModelToTaskEntity on TaskModel {
  TaskEntity mapTusks() {
    return TaskEntity(
      title: title ?? '',
      eventContext: eventContext ?? '',
      date: date ?? '',
      status: status ?? '',
    );
  }
}
