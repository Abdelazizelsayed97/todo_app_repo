import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_task_todo_listapp/core/consts/consts.dart';
import 'package:second_task_todo_listapp/features/notifications/ui_layer/pages/notification_page.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/enums/status_enum.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tab_bar_pages/custom_tasks_page.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/text_styles/text_styles.dart';
import '../../../../core/widgets/toast.dart';
import '../../../auth/ui/cubit/auth_cubit.dart';
import '../../../auth/ui/ui/pages/login/login_page.dart';
import '../../../notifications/ui_layer/widget/notification_body.dart';
import '../../domain/entities/add_event_entity.dart';
import '../tusks_cubit.dart';
import '../widgets/status_filter_bar_widget.dart';
import 'add_and_edit_event_page.dart';

class MainTasksPage extends StatefulWidget {
  const MainTasksPage({super.key});

  @override
  State<MainTasksPage> createState() => _MainTasksPageState();
}

class _MainTasksPageState extends State<MainTasksPage> {
  TapsEnumType _type = TapsEnumType.All;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _setupFirebaseMessaging();
    _setUserCredentials();
    _fetchTasks();
  }

  Future<void> _setupFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        _showNotificationBanner(
            notification.title ?? '', message.notification?.body ?? '');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        _showNotificationBanner(
            notification.title ?? '', notification.body ?? '');
      }
    });
  }

  void _showNotificationBanner(String title, String body) {
    final overFlow = Overlay.of(context);
    final overFlowContext = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: NotificationBanner(
          message: title,
          duration: const Duration(seconds: 10),
          body: body,
        ),
      ),
    );

    overFlow.insert(overFlowContext);

    Future.delayed(const Duration(seconds: 10), () {
      overFlowContext.remove();
    });
  }

  void _setUserCredentials() {
    final String userEmail =
        FirebaseAuth.instance.currentUser?.email ?? 'No email';
    AppConsts.collectionName = userEmail;
  }

  void _fetchTasks() {
    context.read<TusksCubit>().getEvents();
  }

  Future<void> _logOut() async {
    await context.read<AuthCubit>().signOut();
  }

  Widget _getTasksPage(List<TaskEntity>? tasks) {
    switch (_type) {
      case TapsEnumType.Urgent:
        return CustomTasksPage(
            data: tasks, selectStatusEnum: StatusEnum.urgent);
      case TapsEnumType.Complete:
        return CustomTasksPage(
            data: tasks, selectStatusEnum: StatusEnum.completed);
      case TapsEnumType.UnComplete:
        return CustomTasksPage(
            data: tasks, selectStatusEnum: StatusEnum.uncompleted);
      default:
        return CustomTasksPage(data: tasks, selectStatusEnum: null);
    }
  }

  void _navigateToAddEventPage({required TaskEntity data}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAndEditEventPage(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TusksCubit, TusksState>(
      listener: (context, state) {
        if (state is DeleteSuccess) {
          ShowToast.showToastMessage(message: state.message);
        } else if (state is GetFailure) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
        if (state is GetLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetSuccess) {
          return StreamBuilder(
            stream: state.data,
            builder: (context, snapshot) {
              final tasks = snapshot.data;
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    const newTask = TaskEntity(
                      title: '',
                      eventContext: '',
                      date: '',
                      status: '',
                    );
                    _navigateToAddEventPage(data: newTask);
                  },
                  child: const Icon(Icons.add),
                ),
                body: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    }
                  },
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _appBarWidget(),
                          verticalSpace(10),
                          StatusFilterBar(
                            currentTapsEnum: _type,
                            onChange: (tap) {
                              setState(() {
                                _type = tap;
                              });
                            },
                          ),
                          verticalSpace(20),
                          Expanded(child: _getTasksPage(tasks)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Scaffold();
        }
      },
    );
  }

  Widget _appBarWidget() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Welcome!',
            style: Styles.bold(fontSize: 32.sp, color: Colors.black),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationPage()),
          ),
          icon: const Icon(Icons.notifications_active_outlined,
              color: Colors.black26),
        ),
        IconButton(
          onPressed: _logOut,
          icon: const Icon(Icons.logout, color: Colors.red),
        ),
      ],
    );
  }
}
