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


class TusksPage extends StatefulWidget {
  const TusksPage({super.key});

  @override
  State<TusksPage> createState() => _TusksPageState();
}

class _TusksPageState extends State<TusksPage>
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
  Widget build(BuildContext context) {
    return BlocBuilder<TusksCubit, TusksState>(
      builder: (context, state) {
        if (state is GetLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetSuccess) {
          // final data = state.data.first.then((value) => value.map((e) => ))
          return StreamBuilder(
            stream: state.data,
            builder: (context, listOfTusksState) {
              print('=====> ${listOfTusksState.data}');
              print('=====> ${listOfTusksState.runtimeType}');

              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  AddEventPage(data: listOfTusksState.data, pageTitle: 'Add Event',),
                        ));
                  },
                  child: const Icon(Icons.add),
                ),
                body: DefaultTabController(
                  initialIndex: 0,
                  length: 4,
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: tabController,
                                  children: [
                                    AllTasksPage(data: listOfTusksState.data),
                                    UrgentTasksPage(
                                      data: listOfTusksState.data,
                                    ),
                                    CompletedTasksPage(data: listOfTusksState.data,),
                                    UnCompletedTasksPage(data: listOfTusksState.data,),
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
        }
        return const SizedBox.shrink();
      },
    );
  }
}
