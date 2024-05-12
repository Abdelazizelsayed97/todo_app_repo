// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tusk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      eventContext: json['eventContext'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'title': instance.title,
      'eventContext': instance.eventContext,
      'date': instance.date,
      'status': instance.status,
      'id': instance.id,
    };
