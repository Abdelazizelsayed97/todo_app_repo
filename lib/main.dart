import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/tusks_cubit.dart';
import 'package:shimmer/main.dart';

import 'core/di/di.dart';
import 'features/tusk/ui/pages/tusks_page.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'ToDoApp');
  await AppDi.setupGetIt();

  runApp( ToDoApp(
    MaterialApp(
      builder: FToastBuilder(),
      home: const MyApp(),
      navigatorKey: navigatorKey,
    ),
  ));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp(MaterialApp materialApp, {super.key});

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
