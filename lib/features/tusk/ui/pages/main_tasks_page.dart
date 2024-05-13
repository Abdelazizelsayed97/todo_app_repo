import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/enums/status_enum.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/tab_bar_pages/custom_tasks_page.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/text_styles/text_styles.dart';
import '../tusks_cubit.dart';
import '../widgets/status_widget.dart';
import 'add_event_page.dart';

class MainTasksPage extends StatefulWidget {
  const MainTasksPage({super.key});

  @override
  State<MainTasksPage> createState() => _MainTasksPageState();
}

class _MainTasksPageState extends State<MainTasksPage>
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
            builder: (context, allData) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEventPage(
                            data: allData.data,
                            pageTitle: 'Add Event',
                          ),
                        ));
                  },
                  child: const Icon(Icons.add),
                ),
                body: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.all(12.0.r),
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
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              //All
                              CustomTasksPage(
                                  data: allData.data, selectStatusEnum: null),
                              //Urgent
                              CustomTasksPage(
                                  data: allData.data,
                                  selectStatusEnum: StatusEnum.urgent),
                              //Completed
                              CustomTasksPage(
                                  data: allData.data,
                                  selectStatusEnum: StatusEnum.completed),
                              //Uncompleted
                              CustomTasksPage(
                                  data: allData.data,
                                  selectStatusEnum: StatusEnum.uncompleted),
                            ],
                          ),
                        ),
                      ],
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
