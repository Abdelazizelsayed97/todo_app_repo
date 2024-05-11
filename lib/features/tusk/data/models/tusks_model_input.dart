import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/add_event_entity.dart';

part 'tusks_model_input.g.dart';

@JsonSerializable()
class TaskModelInput {
  final String? title;
  final String? eventContext;
  final String? date;
  final String? status;
  final String? id;

  TaskModelInput(
      {this.id, this.title, this.eventContext, this.date, this.status});

  factory TaskModelInput.fromJson(Map<String, dynamic> json) =>
      _$TaskModelInputFromJson(json);

  factory TaskModelInput.fromInput(TaskEntity input) {
    return TaskModelInput(
        title: input.title,
        date: input.date,
        eventContext: input.eventContext,
        status: input.status,
        id: input.id);
  }

  Map<String, dynamic> toJson() => _$TaskModelInputToJson(this);
}
