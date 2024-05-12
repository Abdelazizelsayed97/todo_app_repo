import 'package:freezed_annotation/freezed_annotation.dart';

part 'tusk_model.g.dart';

@JsonSerializable()
class TaskModel {
  final String? title;
  final String? eventContext;
  final String? date;
  final String? status;
  final String? id;

  TaskModel({this.id, this.title, this.eventContext, this.date, this.status});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
