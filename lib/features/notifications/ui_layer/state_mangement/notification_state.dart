part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.getNotificationLoading() = GetNotificationLoading;
  const factory NotificationState.getNotificationSuccess(final List<NotificationModel> notification) = GetNotificationSuccess;
  const factory NotificationState.getNotificationFailure(String e) = GetNotificationFailure;
}
