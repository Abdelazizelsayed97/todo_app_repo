
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data_layer/ repositories/auth_repositories_impl.dart';
import '../../features/auth/domain/repository/auth_repositories.dart';
import '../../features/auth/domain/use_case/log_out_use_case.dart';
import '../../features/auth/domain/use_case/login_use_case.dart';
import '../../features/auth/domain/use_case/registration_via_email_use_case.dart';
import '../../features/auth/domain/use_case/registration_via_phone_number_use_case.dart';
import '../../features/auth/ui/cubit/auth_cubit.dart';
import '../../features/notifications/data_layer/repository/notification_repository_impl.dart';
import '../../features/notifications/domain_layer/repository/notification_repository.dart';
import '../../features/notifications/domain_layer/use_case/get_notification_use_case.dart';
import '../../features/notifications/ui_layer/state_mangement/notification_cubit.dart';
import '../../features/tusk/data/repos/tusks_impl.dart';
import '../../features/tusk/domain/repos/task_repository.dart';
import '../../features/tusk/domain/use_cases/add_event_use_case.dart';
import '../../features/tusk/domain/use_cases/delete_event_use_case.dart';
import '../../features/tusk/domain/use_cases/edit_event_use_case.dart';
import '../../features/tusk/domain/use_cases/get_event_use_case.dart';
import '../../features/tusk/ui/tusks_cubit.dart';

final injector = GetIt.instance;

class AppDi {
  static Future<void> authDi() async {
    injector.registerFactory<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );

    injector
        .registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImpl());
    injector.registerLazySingleton(() => LoginUseCase(injector()));
    injector.registerLazySingleton(() => RegistrationUseCase(injector()));
    injector.registerLazySingleton(() => LogoutUseCase(injector()));
    injector.registerLazySingleton(
        () => RegistrationViaPhoneNumberUseCase(injector()));
    injector.registerFactory(
        () => AuthCubit(injector(), injector(), injector(), injector()));
  }
  static Future<void> notifyDi() async {
    injector.registerFactory<FirebaseMessaging>(
          () => FirebaseMessaging.instance,
    );

    injector.registerLazySingleton<NotificationRepository>(
            () => NotificationRepositoryImpl(firebaseMessaging: injector()));
    injector.registerLazySingleton(() => GetNotificationUseCase(injector()));

    injector.registerFactory(() => NotificationCubit(
      injector(),
    ));
  }
  static Future<void> tasksDi() async {
    injector.registerSingleton<TusksRepository>(
      TusksRepositoryImpl(),
    );
    injector.registerLazySingleton<AddEventUseCase>(
          () => AddEventUseCase(injector<TusksRepository>()),
    );

    injector.registerFactory<FirebaseFirestore>(
          () => FirebaseFirestore.instance,
    );

    injector.registerFactory<DeleteEventUseCase>(
          () => DeleteEventUseCase(injector<TusksRepository>()),
    );
    injector.registerFactory<EditEventUseCase>(
          () => EditEventUseCase(injector<TusksRepository>()),
    );
    injector.registerFactory<GetEventUseCase>(
          () => GetEventUseCase(injector<TusksRepository>()),
    );

    injector.registerFactory<TusksCubit>(
          () => TusksCubit(
            injector<AddEventUseCase>(),
            injector<DeleteEventUseCase>(),
            injector<EditEventUseCase>(),
            injector<GetEventUseCase>(),
      ),
    );
  }
}
