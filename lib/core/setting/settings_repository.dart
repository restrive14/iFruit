import 'package:shared_preferences/shared_preferences.dart';

import 'app_setting.dart';

class SettingsRepository {
  final SharedPreferences _prefs;

  SettingsRepository(this._prefs);

  static const String _backgroundKey = 'settings.background';
  static const String _inviteSoundKey = 'settings.invite_sound';
  static const String _ringtoneKey = 'settings.ringtone';
  static const String _snapmaticKey = 'settings.snapmatic';
  static const String _themeKey = 'settings.theme';
  static const String _vibrationKey = 'settings.vibration';
  static const String _fontKey = 'settings.font';

  /// 从本地读取设置
  AppSettings loadSettings() {
    return AppSettings(
      backgroundIndex: _prefs.getInt(_backgroundKey) ?? 0,
      inviteSoundIndex: _prefs.getInt(_inviteSoundKey) ?? 0,
      ringtoneIndex: _prefs.getInt(_ringtoneKey) ?? 0,
      snapmaticIndex: _prefs.getInt(_snapmaticKey) ?? 0,
      themeIndex: _prefs.getInt(_themeKey) ?? 0,
      vibrationIndex: _prefs.getInt(_vibrationKey) ?? 0,
      fontIndex: _prefs.getInt(_fontKey) ?? 0,
    );
  }

  /// 保存背景
  Future<void> saveBackground(int index) async {
    await _prefs.setInt(_backgroundKey, index);
  }

  /// 保存邀请声音
  Future<void> saveInviteSound(int index) async {
    await _prefs.setInt(_inviteSoundKey, index);
  }

  /// 保存铃声
  Future<void> saveRingtone(int index) async {
    await _prefs.setInt(_ringtoneKey, index);
  }

  /// 保存 Snapmatic
  Future<void> saveSnapmatic(int index) async {
    await _prefs.setInt(_snapmaticKey, index);
  }

  /// 保存主题
  Future<void> saveTheme(int index) async {
    await _prefs.setInt(_themeKey, index);
  }

  /// 保存振动
  Future<void> saveVibration(int index) async {
    await _prefs.setInt(_vibrationKey, index);
  }

  /// 保存字体
  Future<void> saveFont(int index) async {
    await _prefs.setInt(_fontKey, index);
  }
}
