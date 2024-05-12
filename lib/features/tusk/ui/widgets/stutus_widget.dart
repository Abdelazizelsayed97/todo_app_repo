import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/consts/consts.dart';

class StatusWidget extends StatefulWidget {
  final TabController tabController;

  const StatusWidget({Key? key, required this.tabController}) : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: TabBar(
        isScrollable: false,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        controller: widget.tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Colors.brown.shade500,
        ),
        labelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        tabAlignment: TabAlignment.fill,
        physics: const AlwaysScrollableScrollPhysics(),
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        tabs: [
          for (var status in AppConsts.statusList)
            Tab(
              child: Container(
                height: 35.h,
                width: 80.w,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
