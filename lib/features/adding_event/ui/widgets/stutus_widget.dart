import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/consts/consts.dart';
import 'package:second_task_todo_listapp/core/helper/spacing.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r)),
            child: MaterialButton(disabledColor: Colors.grey,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              hoverColor: Colors.red,
              color: Colors.green,
              
            
              // alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(24.r),
              //   ),
              // ),
              onPressed: () {},
              child: Text(AppConsts.statusList[index]),
            ),
          );
        },
        itemCount: AppConsts.statusList.length,
        separatorBuilder: (BuildContext context, int index) {
          return horizontalSpace(10);
        },
      ),
    );
  }
}
