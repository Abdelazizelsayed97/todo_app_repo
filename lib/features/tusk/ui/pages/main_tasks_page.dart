import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/consts/consts.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/enums/status_enum.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tab_bar_pages/custom_tasks_page.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/text_styles/text_styles.dart';
import '../../../../core/widgets/toast.dart';
import '../../../auth/ui/cubit/auth_cubit.dart';
import '../../../auth/ui/ui/pages/login/login_page.dart';
import '../tusks_cubit.dart';
import '../widgets/status_filter_bar_widget.dart';
import 'add_and_edit_event_page.dart';

class MainTasksPage extends StatefulWidget {
  const MainTasksPage({super.key});

  @override
  State<MainTasksPage> createState() => _MainTasksPageState();
}

class _MainTasksPageState extends State<MainTasksPage> {
  @override
  void initState() {
    getCredentials();
    getTusks();

    super.initState();
  }

  void getCredentials() {
    final String userEmail =
        FirebaseAuth.instance.currentUser?.email ?? 'No email';
    AppConsts.collectionName = userEmail;
  }

  void getTusks() {
    context.read<TusksCubit>().getEvents();
  }

  TapsEnumType _type = TapsEnumType.All;

  void _logOut() {
    context.read<AuthCubit>().signOut();
  }

  _getType(List<TaskEntity>? data) {
    switch (_type) {
      case TapsEnumType.All:
        return CustomTasksPage(data: data, selectStatusEnum: null);
      case TapsEnumType.Urgent:
        return CustomTasksPage(data: data, selectStatusEnum: StatusEnum.urgent);
      case TapsEnumType.Complete:
        return CustomTasksPage(
            data: data, selectStatusEnum: StatusEnum.completed);
      case TapsEnumType.UnComplete:
        return CustomTasksPage(
            data: data, selectStatusEnum: StatusEnum.uncompleted);
    }
  }

  void _navigateToAddEventPage({required TaskEntity data}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAndEditEventPage(
          data: data,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TusksCubit, TusksState>(
      listener: (context, state) {
        if (state is DeleteSuccess) {
          ShowToast.showToastMessage(message: state.message);
        }
      },
      builder: (context, state) {
        if (state is GetSuccess) {
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
                    _navigateToAddEventPage(
                      data: newTask,
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                body: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }
                  },
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Welcome !',
                                style: Styles.bold(
                                  fontSize: 32.sp,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _logOut();
                                },
                                icon: const Icon(Icons.logout),
                              )
                            ],
                          ),
                          verticalSpace(10),
                          StatusFilterBar(
                            currentTapsEnum: _type,
                            onChange: (tap) {
                              _type = tap;
                              setState(() {});
                            },
                          ),
                          verticalSpace(20),
                          Expanded(
                            child: _getType(
                              tasks,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is GetFailure) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
}
