import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:second_task_todo_listapp/features/notifications/domain_layer/use_case/get_notification_use_case.dart';

import '../../data_layer/models/notification_model.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._getNotificationUseCase) : super(const NotificationState.initial());
  final GetNotificationUseCase _getNotificationUseCase;

  Future<void> getNotification() async {
    final result = await _getNotificationUseCase.getNotification();
    emit(const NotificationState.getNotificationLoading());
 await _getNotificationUseCase.getNotification();
    emit( NotificationState.getNotificationSuccess(result));
  }
}

  //
  // Future<void> getNotification() async {
  //   emit(const NotificationState.getNotificationLoading());
  //   try {
  //     final result = await _getNotificationUseCase.getNotification();
  //     emit(NotificationState.getNotificationSuccess(result));
  //   } catch (e) {
  //     emit(NotificationState.getNotificationFailure(e.toString()));
  //   }
  //   // return emit(NotificationState.getNotificationSuccess(result));
  // }
// }
