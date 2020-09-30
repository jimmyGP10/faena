import 'package:flutter/material.dart';

class User {
  final String email;
  final String photoURL;
  final String pathURL;
  final String uid;
  final String displayName;
  final bool visible;

  User({
    Key key,
    this.uid,
    @required this.email,
    @required this.photoURL,
    this.pathURL,
    @required this.displayName,
    this.visible,
  });
}
