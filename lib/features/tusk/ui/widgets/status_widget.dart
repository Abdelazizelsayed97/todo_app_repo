import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/consts/consts.dart';

class StatusWidget extends StatefulWidget {
  final TabController tabController;

  const StatusWidget({super.key, required this.tabController});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  bool isIndicator = false;

  @override
  void initState() {
    widget.tabController.addListener(() {
      widget.tabController.index;
      widget.tabController.indexIsChanging;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.transparent,
      isScrollable: false,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      controller: widget.tabController,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.brown.shade500,
      ),
      dividerColor: Colors.transparent,
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
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                    color: widget.tabController.indexIsChanging ||
                            widget.tabController.index !=
                                widget.tabController.index
                        ? Colors.transparent
                        : Colors.grey),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                status,
              ),
            ),
          ),
      ],
    );
  }
}
