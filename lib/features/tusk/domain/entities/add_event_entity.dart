import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String title;
  final String eventContext;
  final String date;
  final String status;
  final String? id;

  const TaskEntity({
    required this.title,
    required this.eventContext,
    required this.date,
    required this.status,
    this.id,
  });

  @override
  List<Object?> get props => [title, eventContext, date, status,id];
}
