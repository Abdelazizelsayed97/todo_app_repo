import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/add_event_entity.dart';

abstract class TusksRepository {
  Future<void> addEvent(TuskEntity input);

  Future<void> deleteEvent(String? id);

  Future<void> editEvent({TuskEntity? input, String? collectionPath});

  Stream<List<QueryDocumentSnapshot<TuskEntity>>> getEvent();
}
