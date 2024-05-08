import 'package:get_it/get_it.dart';
import 'package:second_task_todo_listapp/features/adding_event/data/repos/tusks_impl.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/repos/add_event_repository.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/use_cases/add_event_use_case.dart';

import '../../features/adding_event/domain/use_cases/delete_event_use_case.dart';
import '../../features/adding_event/domain/use_cases/edit_event_use_case.dart';
import '../../features/adding_event/domain/use_cases/get_event_use_case.dart';

final getIt = GetIt.instance;

class AppDi {
  static Future<void> setupGetIt() async {
    getIt.registerLazySingleton(() => () => AddEventUseCase(getIt()));
    getIt.registerLazySingleton(() => () => DeleteEventUseCase(getIt()));
    getIt.registerLazySingleton(() => () => EditEventUseCase(getIt()));
    getIt.registerLazySingleton(() => () => GetEventUseCase(getIt()));
    getIt.registerLazySingleton<TusksRepository>(
      () => TusksRepositoryImpl(),
    );
  }
}
