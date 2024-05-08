import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/entities/add_event_entity.dart';
import 'package:second_task_todo_listapp/features/adding_event/domain/repos/add_event_repository.dart';

import '../models/tusks_model_input.dart';

class TusksRepositoryImpl implements TusksRepository {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("Tusk");

  @override
  Future<void> addEvent(TuskEntity input) async {
    final data = TaskModelInput.fromInput(input).toJson();

    await collection.add(data);
    await collection;
  }

  @override
  Future<void> deleteEvent(String? id) async {
    await collection.doc(id).delete();
  }

  @override
  Future<void> editEvent({TuskEntity? input, String? collectionPath}) async {
    collection.doc(collectionPath);
  }

  @override
  Stream<List<QueryDocumentSnapshot<TuskEntity>>> getEvent() {
    collection.snapshots();
    return getEvent();
  }
}
