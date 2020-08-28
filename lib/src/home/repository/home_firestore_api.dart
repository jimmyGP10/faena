import 'package:cloud_firestore/cloud_firestore.dart';

class HomeFirebaseApi {
  Firestore _firestore = Firestore.instance;
  Stream<QuerySnapshot> getCategories() {
    return _firestore.collection('categories').snapshots();
  }
}
