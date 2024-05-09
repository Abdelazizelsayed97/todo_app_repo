import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/add_event_entity.dart';

part 'tusks_model_input.g.dart';

@JsonSerializable()
class TaskModelInput {
  final String? title;
  final String? eventContext;
  final String? date;
  final String? status;

  TaskModelInput({this.title, this.eventContext, this.date, this.status});

  factory TaskModelInput.fromJson(Map<String, dynamic> json) =>
      _$TaskModelInputFromJson(json);

  factory TaskModelInput.fromInput(TuskEntity input) {
    return TaskModelInput(
        title: input.title,
        date: input.date,
        eventContext: input.eventContext,
        status: input.status);
  }

  Map<String, dynamic> toJson() => _$TaskModelInputToJson(this);
}
