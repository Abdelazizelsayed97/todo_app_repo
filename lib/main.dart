import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_task_todo_listapp/core/di/auth_di.dart';
import 'package:second_task_todo_listapp/features/auth/ui/cubit/auth_cubit.dart';
import 'package:second_task_todo_listapp/features/auth/ui/ui/pages/login/login_page.dart';
import 'package:second_task_todo_listapp/features/notifications/ui_layer/state_mangement/notification_cubit.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/tusks_cubit.dart';

import 'features/tusk/ui/pages/main_tasks_page.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'ToDoApp');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission();
 await AppDi.authDi();
 await AppDi.notifyDi();
 await AppDi.tasksDi();
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
            create: (context) =>
                TusksCubit(injector(), injector(), injector(), injector()),
          ),
          BlocProvider(
            create: (context) => NotificationCubit(
              injector(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: credential == null ? const LoginPage() : const MainTasksPage(),
        ),
      ),
    );
  }
}
