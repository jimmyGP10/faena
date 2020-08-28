import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faena/src/authentication/bloc/bloc_auth.dart';
import 'package:faena/src/authentication/ui/screens/login.dart';
import 'package:faena/src/home/UI/widgets/carrousel.dart';
import 'package:faena/src/home/bloc/bloc_home.dart';
import 'package:faena/src/home/models/category.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  static const route = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(children: <Widget>[
          Expanded(child: Text('Home')),
        ])),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          StreamBuilder(
              stream: homeBloc.getCategories(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                List<Category> category =
                    homeBloc.buildListCategory(snapshot.data.documents);
                return Carrousel(categoryList: category);
              }),
          Container(
              child: GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(
                          top: 20, bottom: 10, left: 30, right: 30),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Cerrar Sesión',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )),
                  onTap: () {
                    authBloc.signOut().then((onValue) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false);
                    });
                  })),
        ]))));
  }
}
