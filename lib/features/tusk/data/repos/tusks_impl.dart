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
  Stream<List<TuskEntity>> getTasks() {

    return collection.snapshots().map((querySnapshot) {
      print('jknsdlgfs;');
      return querySnapshot.docs.map((doc) {
        return TuskEntity(
          id: doc.id,
          title: doc['title'],
          date: doc['date'],
          status: doc['status'],
          eventContext: doc['eventContext'],
        );
      }).toList();

    });
  }

}
