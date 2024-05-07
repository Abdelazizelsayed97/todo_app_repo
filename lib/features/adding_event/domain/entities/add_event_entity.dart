import 'package:equatable/equatable.dart';

class AddEventEntity extends Equatable {
  final String title;
  final String eventContext;
  final String date;
  final String status;

  const AddEventEntity(
      {required this.title,
      required this.eventContext,
      required this.date,
      required this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [title, eventContext, date, status];
}
