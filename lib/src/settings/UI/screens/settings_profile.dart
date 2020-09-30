import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faena/src/authentication/bloc/bloc_auth.dart';
import 'package:faena/src/authentication/model/user.dart';
import 'package:faena/src/settings/bloc/settings_bloc.dart';

import '../../../authentication/bloc/bloc_auth.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetting extends StatefulWidget {
  ProfileSetting({Key key}) : super(key: key);
  static const route = "profile-setting";

  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  TextEditingController userName = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authBloc.getUser,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData && snapshot.data.email != null) {
          return _buildUserInfo(context, snapshot.data.uid);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildUserInfo(context, userId) {
    return FutureBuilder(
        future: authBloc.getUserById(userId),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            User user = authBloc.buildUser(snapshot.data);
            if (user == null) {
              return Container();
            } else {
              return _container(context, user);
            }
          } else {
            return Container();
          }
        });
  }

  Widget _container(context, User user) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Perfil')),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(children: <Widget>[
              GestureDetector(
                  child: Stack(
                      alignment: Alignment(0.99, 0.99),
                      children: <Widget>[
                        Container(
                            height: 75,
                            width: 75,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border:
                                    Border.all(width: 1, color: Colors.blue),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: (user.photoURL == null ||
                                            user.photoURL == '')
                                        ? AssetImage('assets/user.png')
                                        : NetworkImage(user.photoURL)))),
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400],
                                      spreadRadius: 2.0,
                                      blurRadius: 5.0,
                                      offset: Offset(1.0, 1.0))
                                ]),
                            child: Icon(Icons.create, color: Colors.black))
                      ]),
                  onTap: () {
                    _settingModalBottomSheet(context, user);
                  }),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(user.displayName),
                        Text(user.email),
                      ]))
            ]),
          ),
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
                        child: Icon(Icons.person, color: Colors.blue)),
                    Expanded(child: Text('Nombre:')),
                    Text(user.displayName),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey)
                  ])),
              onTap: () {
                _changeUserName(context, user);
              }),
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
                        child: Icon(Icons.visibility, color: Colors.blue)),
                    Expanded(child: Text('Visible:')),
                    (user.visible == true) ? Text('Visible') : Text('Oculto'),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey)
                  ])),
              onTap: () {
                _changeUserVisible(context, user);
              }),
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
                        child: Icon(Icons.lock, color: Colors.blue)),
                    Expanded(child: Text('Contraseña:')),
                    Text('******'),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey)
                  ])),
              onTap: () {
                _passwordRecovery(context, user);
              })
        ]))));
  }

  _passwordRecovery(context, User user) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
                'Se enviara un correo a ${user.email} para realizar el proceso de cambiar la contraseña.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    settingsBloc.sendPasswordResetEmail(user.email);
                    Navigator.pop(context);
                  },
                  child: Text('Enviar')),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'))
            ],
          );
        });
  }

  _changeUserVisible(context, User user) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
                'Seleccione una de las opciones para que su perfil este visible u oculto para los demás'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    setState(() {
                      settingsBloc.updateCurrentUserVisible(user.uid, true);
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Visible')),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      settingsBloc.updateCurrentUserVisible(user.uid, false);
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Oculto')),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'))
            ],
          );
        });
  }

  _changeUserName(context, User user) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: TextFormField(
              controller: userName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                labelStyle: TextStyle(color: Colors.grey[700]),
                labelText: "* Nombre",
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (userName.text.isNotEmpty) {
                      setState(() {
                        settingsBloc.updateCurrentUserName(
                            user.uid, userName.text);
                        Navigator.pop(context);
                        userName = new TextEditingController(text: '');
                      });
                    }
                  },
                  child: Text('Cambiar')),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'))
            ],
          );
        });
  }

  void _settingModalBottomSheet(context, User user) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              child: _buildOptionsImage(context, user),
              decoration: BoxDecoration(
                  //color: Theme.of(context).canvasColor,
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10))),
            ),
          );
        });
  }

  Widget _buildOptionsImage(context, User user) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter stater) {
      return Wrap(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 25, top: 25),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.blue,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () async {
                        stater(() {
                          _addImageCamera(context, user);
                          Navigator.pop(context);
                        });
                      },
                      textColor: Colors.white,
                      child: Text('Cámara', style: TextStyle(fontSize: 18))),
                  SizedBox(width: 20),
                  RaisedButton(
                      color: Colors.blue,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () async {
                        // setState(() {
                        _addImage(context, user);
                        Navigator.pop(context);
                        // });
                      },
                      textColor: Colors.white,
                      child: Text('Galería', style: TextStyle(fontSize: 18)))
                ])),
      ]);
    });
  }

  void _addImage(context, User user) async {
    var image;
    File compressedImage;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      compressedImage = await FlutterNativeImage.compressImage(image.path,
          quality: 50, percentage: 50);
      setState(() {
        settingsBloc.updateCurrentUserPhoto(
            user.uid, compressedImage, user.pathURL);
        Navigator.pop(context);
      });
    } catch (e) {
      print("Error");
      print(e);
      return null;
    }
    image = null;
  }

  void _addImageCamera(context, User user) async {
    var image;
    File compressedImage;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      compressedImage = await FlutterNativeImage.compressImage(image.path,
          quality: 50, percentage: 50);
      setState(() {
        settingsBloc.updateCurrentUserPhoto(
            user.uid, compressedImage, user.pathURL);
        Navigator.pop(context);
      });
    } catch (e) {
      print("Error");
      print(e);
      return null;
    }
    image = null;
  }
}
