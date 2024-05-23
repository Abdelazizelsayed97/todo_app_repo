import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_task_todo_listapp/core/di/auth_di.dart';
import 'package:second_task_todo_listapp/features/auth/ui/cubit/auth_cubit.dart';
import 'package:second_task_todo_listapp/features/auth/ui/ui/pages/login/login_page.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/tusks_cubit.dart';

import 'core/di/tasks_di.dart';
import 'features/tusk/ui/pages/main_tasks_page.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'ToDoApp');

  await AuthDi.setup();
  await TasksDi.setupGetIt();
  runApp(ToDoApp(
    MaterialApp(
      builder: FToastBuilder(),
      home: const ToDoApp(MaterialApp()),
      navigatorKey: navigatorKey,
    ),
  ));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp(MaterialApp materialApp, {super.key});

  @override
  Widget build(BuildContext context) {
    final credential = FirebaseAuth.instance.currentUser;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthCubit(injector(), injector(), injector(), injector()),
          ),
          BlocProvider(
            create: (context) => TusksCubit(getIt(), getIt(), getIt(), getIt()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: credential == null ? const LoginPage() : const MainTasksPage(),
        ),
      ),
    );
  }
}
