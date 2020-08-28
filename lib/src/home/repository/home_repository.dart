import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faena/src/home/repository/home_firestore_api.dart';

class HomeRepository {
  final _homeFirebaseApi = HomeFirebaseApi();

  Stream<QuerySnapshot> getCategories() => _homeFirebaseApi.getCategories();
}
