import 'dart:io';
import 'package:faena/src/settings/repository/settings_firestore_api.dart';

class SettingsRepository {
  final _settingsFirestoreApi = SettingsFirestoreApi();

  Future<void> sendPasswordResetEmail(String email) =>
      _settingsFirestoreApi.sendPasswordResetEmail(email);

  Future<void> updateCurrentUserVisible(String uid, bool visible) =>
      _settingsFirestoreApi.updateCurrentUserVisible(uid, visible);

  Future<void> updateCurrentUserName(String uid, String name) =>
      _settingsFirestoreApi.updateCurrentUserName(uid, name);

  Future<void> updateCurrentUserPhoto(
          String uid, File image, String pathPhoto) =>
      _settingsFirestoreApi.updateCurrentUserPhoto(uid, image, pathPhoto);
}
