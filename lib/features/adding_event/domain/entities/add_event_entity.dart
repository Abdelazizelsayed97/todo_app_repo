import 'package:equatable/equatable.dart';

class TuskEntity extends Equatable {
  final String title;
  final String eventContext;
  final String date;
  final String status;

  const TuskEntity(
      {required this.title,
      required this.eventContext,
      required this.date,
      required this.status});

  @override

  List<Object?> get props => [title, eventContext, date, status];
}
