import 'package:cloud_firestore/cloud_firestore.dart';

class WebServicesControl {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("Tusk");

  Future<void> addToFireStore(
      {required String title,
      required String status,
      required String date,
      required String eventContext}) async {
    final Map<String, dynamic> data = {
      'title': title,
      'eventContext': eventContext,
      'date': date,
      'status': status,
    };

    await collection.add(data);
  }
}
