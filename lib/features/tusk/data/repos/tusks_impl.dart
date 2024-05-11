import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/add_event_entity.dart';
import '../../domain/repos/task_repository.dart';
import '../models/tusks_model_input.dart';

class TusksRepositoryImpl implements TusksRepository {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("Tusk");

  TusksRepositoryImpl();

  @override
  Future<void> addEvent(TaskEntity input) async {
    final data = TaskModelInput.fromInput(input).toJson();
    if (data.isEmpty) {
      throw Exception();
    } else {
      await collection.add(data);
    }
  }

  @override
  Future<void> deleteEvent(String? id) async {
    if (id == null) {
      throw Exception();
    } else {
      await collection.doc(id).delete();
    }
  }

  @override
  Future<void> editEvent({TaskEntity? input, String? collectionPath}) async {
    if (input == null || collectionPath == null) {
      throw Exception();
    } else {
      final data = TaskModelInput.fromInput(input).toJson();
      await collection.doc(collectionPath).update(data);
    }
  }

  @override
  Stream<List<TaskEntity>> getTasks() {
    final data = collection.snapshots();
    if (data.isBroadcast) {
      return data.map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return TaskEntity(
            id: doc.id,
            title: doc['title'],
            date: doc['date'],
            status: doc['status'],
            eventContext: doc['eventContext'],
          );
        }).toList();
      });
    } else {
      throw Exception();
    }
  }
}
