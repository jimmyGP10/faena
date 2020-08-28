import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faena/src/home/models/category.dart';
import 'package:faena/src/home/repository/home_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class HomeBloc implements Bloc {
  final _homeRepository = HomeRepository();

  Stream<QuerySnapshot> getCategories() {
    return _homeRepository.getCategories();
  }

  List<Category> buildListCategory(List<DocumentSnapshot> categoryList) {
    List<Category> category = List<Category>();

    categoryList.forEach((c) {
      category.add(Category(
        name: c.data['name'],
        description: c.data['description'],
        photoURL: c.data['photoURL'],
      ));
    });

    return category;
  }

  void dispose() {}
}

final homeBloc = HomeBloc();
