import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/add_event_page.dart';

class EventCardBody extends StatelessWidget {
  EventCardBody(
      {super.key,
      required this.title,
      required this.eventContext,
      required this.status,
      required this.date,
      required this.id});

  final String title;
  final String eventContext;
  final String status;
  final String date;
  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEventPage(
                      pageTitle: "Edit Event",
                      id: id,
                    )));
      },
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Styles.bold(fontSize: 24, color: Colors.black),
                    ),
                    Text(eventContext,
                        style:
                            Styles.normal(fontSize: 16, color: Colors.black54)),
                    Text(date,
                        style:
                            Styles.light(fontSize: 14, color: Colors.black54)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(status,
                        style:
                            Styles.light(fontSize: 14, color: Colors.black54))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
