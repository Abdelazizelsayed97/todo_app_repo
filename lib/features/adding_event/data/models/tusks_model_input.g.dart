// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tusks_model_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModelInput _$TaskModelFromJson(Map<String, dynamic> json) => TaskModelInput(
      title: json['title'] as String?,
      eventContext: json['eventContext'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModelInput instance) => <String, dynamic>{
      'title': instance.title,
      'eventContext': instance.eventContext,
      'date': instance.date,
      'status': instance.status,
    };
