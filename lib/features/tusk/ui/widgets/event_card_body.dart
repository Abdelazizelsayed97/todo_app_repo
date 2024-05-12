import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';
import 'package:second_task_todo_listapp/features/tusk/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/tusk/ui/pages/add_event_page.dart';

class EventCardBody extends StatelessWidget {
  const EventCardBody({
    super.key,
    required this.title,
    required this.eventContext,
    required this.status,
    required this.date,
    required this.id,
    this.input,
  });

  final String title;
  final String eventContext;
  final String status;
  final String date;
  final String id;
  final TaskEntity? input;

  void _onEditCardPress({context, required TaskEntity input}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddEventPage(
                  editData: input,
                  pageTitle: "Edit Event",
                  id: id,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onEditCardPress(context: context, input: input!);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Styles.bold(fontSize: 18, color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        eventContext,
                        style:
                            Styles.normal(fontSize: 14, color: Colors.black54),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        date,
                        style: Styles.light(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  status,
                  style: Styles.light(fontSize: 14, color: Colors.black54),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
