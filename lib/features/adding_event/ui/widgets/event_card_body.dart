import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';

class EventCardBody extends StatelessWidget {
  const EventCardBody(
      {super.key, this.title, this.eventContext, this.date, this.status});

  final String? title;
  final String? eventContext;
  final String? date;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Flutter Study',
                style: Styles.bold(fontSize: 24, color: Colors.black),
              ),
              Text('State Management',
                  style: Styles.normal(fontSize: 14, color: Colors.grey)),
              Text('State Management',
                  style: Styles.light(fontSize: 12, color: Colors.grey[200])),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(status ?? '',
                  style: Styles.light(fontSize: 12, color: Colors.grey[200]))
            ],
          )
        ],
      ),
    );
  }
}
