import 'package:flutter/foundation.dart';
import '../data/local/database_helper.dart';

enum AppLanguage { english, bangla }

/// Simple in-app language toggle (English / Bangla) persisted in Hive.
/// The app uses a lightweight custom string lookup (AppStrings) rather
/// than full Flutter localization, so switching is instant with no
/// context.locale dependency.
class LocaleProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  static const _key = 'app_language';

  AppLanguage _language = AppLanguage.english;
  AppLanguage get language => _language;
  bool get isBangla => _language == AppLanguage.bangla;

  LocaleProvider() {
    final stored = _db.getSetting<String>(_key);
    if (stored == 'bn') _language = AppLanguage.bangla;
  }

  Future<void> setLanguage(AppLanguage lang) async {
    _language = lang;
    await _db.setSetting(_key, lang == AppLanguage.bangla ? 'bn' : 'en');
    notifyListeners();
  }

  Future<void> toggle() =>
      setLanguage(isBangla ? AppLanguage.english : AppLanguage.bangla);
}
