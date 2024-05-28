import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_todo_listapp/features/notifications/ui_layer/state_mangement/notification_cubit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context.read<NotificationCubit>().getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetNotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetNotificationSuccess) {
            return ListView.builder(
              itemCount: state.notification.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.notification[index].title),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
