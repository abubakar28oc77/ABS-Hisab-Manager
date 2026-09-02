import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import '../core/constants/app_constants.dart';
import '../data/local/database_helper.dart';

class AuthProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final LocalAuthentication _localAuth = LocalAuthentication();

  bool _unlocked = false;
  bool get unlocked => _unlocked;

  bool get hasPin => _db.getSetting<String>(AppConstants.pinKey) != null;

  bool get biometricEnabled =>
      _db.getSetting<bool>(AppConstants.biometricKey) ?? false;

  String _hash(String pin) => sha256.convert(utf8.encode(pin)).toString();

  Future<void> setPin(String pin) async {
    await _db.setSetting(AppConstants.pinKey, _hash(pin));
    notifyListeners();
  }

  Future<void> removePin() async {
    await _db.settingsBox.delete(AppConstants.pinKey);
    await _db.setSetting(AppConstants.biometricKey, false);
    notifyListeners();
  }

  bool verifyPin(String pin) {
    final stored = _db.getSetting<String>(AppConstants.pinKey);
    if (stored == null) return true;
    return stored == _hash(pin);
  }

  Future<void> setBiometricEnabled(bool value) async {
    await _db.setSetting(AppConstants.biometricKey, value);
    notifyListeners();
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticateBiometric() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Authenticate to open ABS Hisab Manager',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      return false;
    }
  }

  void unlock() {
    _unlocked = true;
    notifyListeners();
  }

  void lock() {
    _unlocked = false;
    notifyListeners();
  }
}
