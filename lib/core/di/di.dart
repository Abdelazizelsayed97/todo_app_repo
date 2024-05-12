import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../../features/tusk/data/repos/tusks_impl.dart';
import '../../features/tusk/domain/repos/task_repository.dart';
import '../../features/tusk/domain/use_cases/add_event_use_case.dart';
import '../../features/tusk/domain/use_cases/delete_event_use_case.dart';
import '../../features/tusk/domain/use_cases/edit_event_use_case.dart';
import '../../features/tusk/domain/use_cases/get_event_use_case.dart';
import '../../features/tusk/ui/tusks_cubit.dart';

final getIt = GetIt.instance;
final sl = GetIt.instance;

class AppDi {
  static Future<void> setupGetIt() async {
    getIt.registerSingleton<TusksRepository>(
      TusksRepositoryImpl(),
    );
    getIt.registerLazySingleton<AddEventUseCase>(
      () => AddEventUseCase(getIt<TusksRepository>()),
    );

    getIt.registerFactory<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

    getIt.registerFactory<DeleteEventUseCase>(
      () => DeleteEventUseCase(getIt<TusksRepository>()),
    );
    getIt.registerFactory<EditEventUseCase>(
      () => EditEventUseCase(getIt<TusksRepository>()),
    );
    getIt.registerFactory<GetEventUseCase>(
      () => GetEventUseCase(getIt<TusksRepository>()),
    );

    getIt.registerFactory<TusksCubit>(
      () => TusksCubit(
        getIt<AddEventUseCase>(),
        getIt<DeleteEventUseCase>(),
        getIt<EditEventUseCase>(),
        getIt<GetEventUseCase>(),
      ),
    );
  }
}
