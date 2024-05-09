import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/consts/consts.dart';

class StatusWidget extends StatelessWidget {
  final TabController tabController;

  const StatusWidget({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,

        // isScrollable: true,
        controller: tabController,
        tabs: [
          Tab(text: AppConsts.statusList[0]),
          Tab(text: AppConsts.statusList[1]),
          Tab(text: AppConsts.statusList[2]),
          Tab(text: AppConsts.statusList[3]),
        ],
      ),
    );
  }
}
