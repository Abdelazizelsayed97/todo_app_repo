import 'package:second_task_todo_listapp/features/notifications/data_layer/models/notification_model.dart';
import 'package:second_task_todo_listapp/features/notifications/domain_layer/repository/notification_repository.dart';

class GetNotificationUseCase {
  final NotificationRepository _notificationRepository;

  GetNotificationUseCase(this._notificationRepository);

  Future<List<NotificationModel>> getNotification() async {
    return await _notificationRepository.getNotifications();
  }
}
