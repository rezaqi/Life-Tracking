import 'package:cloud_firestore/cloud_firestore.dart';

class AppSettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String collection = 'appSettings';
  static const String docId = 'main';

  Stream<DocumentSnapshot> getSettingsStream() {
    return _firestore.collection(collection).doc(docId).snapshots();
  }

  Future<bool> getIsOn() async {
    final doc = await _firestore.collection(collection).doc(docId).get();
    return doc.data()?['isOn'] ?? false;
  }

  Future<void> toggleIsOn() async {
    final current = await getIsOn();
    await _firestore.collection(collection).doc(docId).set({
      'isOn': !current,
    }, SetOptions(merge: true));
  }
}
