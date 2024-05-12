import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/tusks_cubit.dart';

import 'core/di/di.dart';
import 'features/tusk/ui/pages/tusks_page.dart';
import 'firebase_options.dart';

typedef AppBuilder = Future<Widget> Function();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'ToDoApp');
  await AppDi.setupGetIt();

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => TusksCubit(getIt(), getIt(), getIt(), getIt()),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TasksPage(),
        ),
      ),
    );
  }
}
