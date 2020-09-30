import 'dart:io';

import 'package:faena/src/settings/repository/settings_repository.dart';

class SettingsBloc {
  final _settingsRepository = SettingsRepository();

  Future<void> sendPasswordResetEmail(String email) {
    return _settingsRepository.sendPasswordResetEmail(email);
  }

  Future<void> updateCurrentUserVisible(String uid, bool visible) {
    return _settingsRepository.updateCurrentUserVisible(uid, visible);
  }

  Future<void> updateCurrentUserName(String uid, String name) {
    return _settingsRepository.updateCurrentUserName(uid, name);
  }

  Future<void> updateCurrentUserPhoto(
      String uid, File image, String pathPhoto) {
    return _settingsRepository.updateCurrentUserPhoto(uid, image, pathPhoto);
  }
}

final settingsBloc = SettingsBloc();
