import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/widgets/notification_listener.dart';

import '../../domain_layer/repository/notification_repository.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirebaseMessaging firebaseMessaging;

  NotificationRepositoryImpl({required this.firebaseMessaging});

  @override
  Future<Notification> createNotification(Notification notification) {
    // TODO: implement createNotification
    throw UnimplementedError();
  }

  @override
  Future<Notification> deleteNotification(int id) {
    // TODO: implement deleteNotification

    throw UnimplementedError();
  }

  @override
  Future<Notification> getNotification(int id) {
    // TODO: implement getNotification
    throw UnimplementedError();
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
   await firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true, criticalAlert: true);
  final response =await firebaseMessaging.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
    });
    return [NotificationModel(
      title:response?.notification?.title??'' ,body: response?.notification?.body??''
    )];
  }

  @override
  Future<Notification> updateNotification(Notification notification) {
    // TODO: implement updateNotification
    throw UnimplementedError();
  }

}
