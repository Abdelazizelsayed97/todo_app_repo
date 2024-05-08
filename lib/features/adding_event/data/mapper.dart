import '../domain/entities/add_event_entity.dart';
import 'models/tusk_model.dart';


extension ConvertTuskModelToTaskEntity on TaskModel {
  TuskEntity mapTusks() {
    return TuskEntity(
      title: title ?? '',
      eventContext: eventContext ?? '',
      date: date ?? '',
      status: status ?? '',
    );
  }
}
