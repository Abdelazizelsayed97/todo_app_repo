import 'package:flutter/cupertino.dart';

import '../../data_layer/models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications();

  Future<Notification> getNotification(int id);

  Future<Notification> createNotification(Notification notification);

  Future<Notification> updateNotification(Notification notification);

  Future<Notification> deleteNotification(int id);
}
