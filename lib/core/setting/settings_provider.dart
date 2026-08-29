import 'package:flutter/material.dart';

import 'app_setting.dart';
import 'settings_repository.dart';

class AppThemeConfig {
  final String name;
  final Color primaryColor;
  final Color textColor;
  final double fontSize;
  final Color dividerColor;

  const AppThemeConfig({
    required this.name,
    required this.primaryColor,
    required this.textColor,
    required this.fontSize,
    required this.dividerColor,
  });
}

class AppFontSizeConfig {
  final String name;
  final double scale;

  const AppFontSizeConfig({required this.name, required this.scale});
}

class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository;

  AppSettings _settings = const AppSettings();

  bool _initialized = false;

  static const List<AppThemeConfig> presetThemes = [
    AppThemeConfig(
      name: '蓝色',
      primaryColor: Color(0xFF4a88d5),
      textColor: Colors.black,
      fontSize: 16,
      dividerColor: Color(0xFFcccccc),
    ),
    AppThemeConfig(
      name: '绿色',
      primaryColor: Color(0xFF217a00),
      textColor: Colors.black,
      fontSize: 16,
      dividerColor: Color(0xFFcccccc),
    ),
    AppThemeConfig(
      name: '灰色',
      primaryColor: Color(0xFF6e7370),
      textColor: Colors.black,
      fontSize: 16,
      dividerColor: Color(0xFFcccccc),
    ),
    AppThemeConfig(
      name: '橙色',
      primaryColor: Color(0xFFcc851f),
      textColor: Colors.black,
      fontSize: 16,
      dividerColor: Color(0xFFcccccc),
    ),
    AppThemeConfig(
      name: '粉色',
      primaryColor: Color(0xFFcb70a5),
      textColor: Colors.black,
      fontSize: 16,
      dividerColor: Color(0xFFcccccc),
    ),
    AppThemeConfig(
      name: '紫色',
      primaryColor: Color(0xFFa473b7),
      textColor: Colors.black,
      fontSize: 16,
      dividerColor: Color(0xFFcccccc),
    ),
    AppThemeConfig(
      name: '红色',
      primaryColor: Color(0xFFad1900),
      textColor: Colors.black,
      fontSize: 16,
      dividerColor: Color(0xFFcccccc),
    ),
  ];

  static const List<AppFontSizeConfig> presetFontSizes = [
    AppFontSizeConfig(name: '小', scale: 0.85),
    AppFontSizeConfig(name: '默认', scale: 1.0),
    AppFontSizeConfig(name: '大', scale: 1.2),
  ];

  SettingsProvider(this._repository);

  AppSettings get settings => _settings;

  bool get initialized => _initialized;

  int get backgroundIndex => _settings.backgroundIndex;

  int get inviteSoundIndex => _settings.inviteSoundIndex;

  int get ringtoneIndex => _settings.ringtoneIndex;

  int get snapmaticIndex => _settings.snapmaticIndex;

  int get themeIndex => _settings.themeIndex;

  int get vibrationIndex => _settings.vibrationIndex;

  int get fontIndex => _settings.fontIndex;

  int get selectedThemeIndex {
    final index = _settings.themeIndex;
    if (index < 0 || index >= presetThemes.length) {
      return 0;
    }
    return index;
  }

  AppThemeConfig get selectedTheme => presetThemes[selectedThemeIndex];

  int get selectedFontIndex {
    final index = _settings.fontIndex;
    if (index < 0 || index >= presetFontSizes.length) {
      return 1;
    }
    return index;
  }

  AppFontSizeConfig get selectedFont => presetFontSizes[selectedFontIndex];

  double get textScale => selectedFont.scale;

  ThemeData get themeData => _buildTheme(selectedTheme);

  ThemeData _buildTheme(AppThemeConfig config) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: config.primaryColor,
      brightness: config.textColor == Colors.white
          ? Brightness.dark
          : Brightness.light,
    ).copyWith(primary: config.primaryColor);

    final scale = textScale;
    final textTheme = TextTheme(
      bodySmall: TextStyle(
        fontSize: 16 * scale,
        height: 1.5,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 18 * scale,
        height: 1.5,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 22 * scale,
        height: 1.5,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 18 * scale,
        height: 1.5,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 20 * scale,
        height: 1.5,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 24 * scale,
        height: 1.5,
        color: Colors.black,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      dividerColor: config.dividerColor,
      pageTransitionsTheme: PageTransitionsTheme(builders: {}),
      textTheme: textTheme,
    );
  }

  int indexOfThemeName(String name) {
    return presetThemes.indexWhere((theme) => theme.name == name);
  }

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    _settings = _repository.loadSettings();
    _initialized = true;
    notifyListeners();
  }

  Future<void> setBackgroundIndex(int index) async {
    _settings = _settings.copyWith(backgroundIndex: index);
    notifyListeners();
    await _repository.saveBackground(index);
  }

  Future<void> setInviteSoundIndex(int index) async {
    _settings = _settings.copyWith(inviteSoundIndex: index);
    notifyListeners();
    await _repository.saveInviteSound(index);
  }

  Future<void> setRingtoneIndex(int index) async {
    _settings = _settings.copyWith(ringtoneIndex: index);
    notifyListeners();
    await _repository.saveRingtone(index);
  }

  Future<void> setSnapmaticIndex(int index) async {
    _settings = _settings.copyWith(snapmaticIndex: index);
    notifyListeners();
    await _repository.saveSnapmatic(index);
  }

  Future<void> setThemeIndex(int index) async {
    if (index < 0 || index >= presetThemes.length) {
      return;
    }

    if (_settings.themeIndex == index) {
      return;
    }

    _settings = _settings.copyWith(themeIndex: index);
    notifyListeners();
    await _repository.saveTheme(index);
  }

  Future<void> setThemeByName(String name) async {
    final index = indexOfThemeName(name);
    if (index == -1) {
      return;
    }

    await setThemeIndex(index);
  }

  Future<void> setVibrationIndex(int index) async {
    _settings = _settings.copyWith(vibrationIndex: index);
    notifyListeners();
    await _repository.saveVibration(index);
  }

  Future<void> setFontIndex(int index) async {
    if (index < 0 || index >= presetFontSizes.length) {
      return;
    }

    if (_settings.fontIndex == index) {
      return;
    }

    _settings = _settings.copyWith(fontIndex: index);
    notifyListeners();
    await _repository.saveFont(index);
  }
}
