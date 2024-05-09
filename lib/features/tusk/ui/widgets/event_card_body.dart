import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/add_event_entity.dart';

class EventCardBody extends StatelessWidget {
  const EventCardBody({super.key, required this.index, required this.data});

  final List<TuskEntity> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index].title ?? '',
                    style: Styles.bold(fontSize: 24, color: Colors.black),
                  ),
                  Text(data[index].eventContext,
                      style: Styles.normal(fontSize: 14, color: Colors.grey)),
                  Text(data[index].date,
                      style:
                          Styles.light(fontSize: 12, color: Colors.grey[200])),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(data[index].status,
                      style:
                          Styles.light(fontSize: 12, color: Colors.grey[200]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
