import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tab_bar_pages/all_page.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tab_bar_pages/completed_page.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tab_bar_pages/uncompleted_page.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tab_bar_pages/urgent_page.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/text_styles/text_styles.dart';
import '../tusks_cubit.dart';
import '../widgets/stutus_widget.dart';
import 'add_event_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    getTusks();
    super.initState();
  }

  void getTusks() {
    context.read<TusksCubit>().getEvents();
  }

  Future<void> _deleteItem(String documentId) async {
    BlocProvider.of<TusksCubit>(context).deleteEvent(documentId);
  }

  @override
  void deactivate() {
    tabController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TusksCubit, TusksState>(
      listener: (context, state) {
        if (state is DeleteSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is AddSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message ?? '')));
        }
      },
      builder: (context, state) {
        if (state is GetSuccess) {
          return StreamBuilder(
            stream: state.data,
            builder: (context, listOfTusksState) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEventPage(
                            data: listOfTusksState.data,
                            pageTitle: 'Add Event',
                          ),
                        ));
                  },
                  child: const Icon(Icons.add),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome !',
                              style: Styles.bold(
                                fontSize: 32.sp,
                                color: Colors.black,
                              ),
                            ),
                            StatusWidget(
                              tabController: tabController,
                            ),
                            verticalSpace(20),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    AllTasksPage(
                                      data: listOfTusksState.data ?? [],
                                      onDelete: (index) => _deleteItem(index),
                                    ),
                                    UrgentTasksPage(
                                      data: listOfTusksState.data,
                                      onDelete: (index) => _deleteItem(index),
                                    ),
                                    CompletedTasksPage(
                                      data: listOfTusksState.data,
                                      onDelete: (index) => _deleteItem(index),
                                    ),
                                    UnCompletedTasksPage(
                                      data: listOfTusksState.data,
                                      onDelete: (index) => _deleteItem(index),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
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
