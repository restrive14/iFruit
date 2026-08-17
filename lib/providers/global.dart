import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingOption {
  int background;
  int invitebell;
  int bell;
  int snapmatic;
  int theme;
  int vibrate;

  SettingOption({
    this.background = 0,
    this.invitebell = 0,
    this.bell = 0,
    this.snapmatic = 0,
    this.theme = 0,
    this.vibrate = 0,
  });
}

class GlobalProvider extends ChangeNotifier {
  static const String _keyBackground = 'background';
  static const String _keyInviteBell = 'invitebell';
  static const String _keyBell = 'bell';
  static const String _keySnapmatic = 'snapmatic';
  static const String _keyTheme = 'theme';
  static const String _keyVibrate = 'vibrate';

  SettingOption _settings = SettingOption();

  SettingOption get settings => _settings;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _settings = SettingOption(
      background: prefs.getInt(_keyBackground) ?? 0,
      invitebell: prefs.getInt(_keyInviteBell) ?? 0,
      bell: prefs.getInt(_keyBell) ?? 0,
      snapmatic: prefs.getInt(_keySnapmatic) ?? 0,
      theme: prefs.getInt(_keyTheme) ?? 0,
      vibrate: prefs.getInt(_keyVibrate) ?? 0,
    );
    notifyListeners();
  }

  int getSettingIndex(String settingId) {
    switch (settingId) {
      case '1':
        return _settings.background;
      case '2':
        return _settings.invitebell;
      case '3':
        return _settings.bell;
      case '4':
        return _settings.snapmatic;
      case '5':
        return _settings.theme;
      case '6':
        return _settings.vibrate;
      default:
        return 0;
    }
  }

  Future<void> setSettingIndex(String settingId, int index) async {
    final safeIndex = index < 0 ? 0 : index;
    final key = _keyForSettingId(settingId);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, safeIndex);

    switch (settingId) {
      case '1':
        _settings.background = safeIndex;
        break;
      case '2':
        _settings.invitebell = safeIndex;
        break;
      case '3':
        _settings.bell = safeIndex;
        break;
      case '4':
        _settings.snapmatic = safeIndex;
        break;
      case '5':
        _settings.theme = safeIndex;
        break;
      case '6':
        _settings.vibrate = safeIndex;
        break;
    }

    notifyListeners();
  }

  String _keyForSettingId(String settingId) {
    switch (settingId) {
      case '1':
        return _keyBackground;
      case '2':
        return _keyInviteBell;
      case '3':
        return _keyBell;
      case '4':
        return _keySnapmatic;
      case '5':
        return _keyTheme;
      case '6':
        return _keyVibrate;
      default:
        return _keyBackground;
    }
  }
}
