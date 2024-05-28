import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String title;
  final String body;

  const NotificationEntity({required this.title, required this.body});

  @override
  List<Object?> get props => [title, body];
}
