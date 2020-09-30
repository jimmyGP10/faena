import 'package:flutter/material.dart';
import 'package:faena/src/settings/ui/screens/settings_profile.dart';

const URL = "https://kiiwik.grupo-prometeo.com/privacy-policy/";

class SettingsHome extends StatefulWidget {
  SettingsHome({Key key}) : super(key: key);
  static const route = "settings-home";
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Ajustes')),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          GestureDetector(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                      )),
                  Expanded(child: Text('Perfil')),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ]),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileSetting()));
              }),
          GestureDetector(
              child: Container(
                margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.library_books,
                        color: Colors.grey,
                      )),
                  Expanded(child: Text('Política De Privacidad')),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ]),
              ),
              onTap: () {}),
        ]))));
  }
}
