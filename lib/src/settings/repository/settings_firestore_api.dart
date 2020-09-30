import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingsFirestoreApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  Future<void> updateCurrentUserPhoto(
      String uid, File image, String pathPhoto) async {
    if (pathPhoto != null || pathPhoto == '') {
      var desertRef = FirebaseStorage.instance.ref().child(pathPhoto);
      desertRef.delete();
    }

    String photoExtension =
        image.path.split(".")[image.path.split('.').length - 1];
    String path = "users/$uid.$photoExtension";
    StorageReference ref = FirebaseStorage.instance.ref().child(path);
    StorageUploadTask uploadTask = ref.putFile(image);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    var downUrl = await storageTaskSnapshot.ref.getDownloadURL();
    var url = downUrl.toString();

    FirebaseUser user = await _auth.currentUser();

    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.photoUrl = url;
    try {
      user.updateProfile(userUpdateInfo);
      _firestore.collection("users").document(uid).updateData({
        'photoURL': url,
        'pathURL': path,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateCurrentUserName(String uid, String name) async {
    FirebaseUser user = await _auth.currentUser();

    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = name;
    if (name != '' || name != null) {
      try {
        user.updateProfile(userUpdateInfo);
        return _firestore.collection("users").document(uid).updateData({
          'displayName': name,
        });
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  Future<void> updateCurrentUserVisible(String uid, bool visible) async {
    if (visible != null) {
      try {
        return _firestore.collection("users").document(uid).updateData({
          'visible': visible,
        });
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
}
