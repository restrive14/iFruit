import 'package:flutter/material.dart';
import 'package:ifruit/utils/theme.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeService _themeService;

  int _selectedThemeIndex = 0;

  ThemeProvider(this._themeService) {
    _loadTheme();
  }

  int get selectedThemeIndex => _selectedThemeIndex;

  AppThemeConfig get selectedTheme => presetThemes[_selectedThemeIndex];

  String get selectedThemeName => selectedTheme.name;

  ThemeData get themeData => buildTheme(selectedTheme);

  int indexOfThemeName(String name) {
    return presetThemes.indexWhere((theme) => theme.name == name);
  }

  Future<void> setThemeIndex(int index) async {
    if (index < 0 || index >= presetThemes.length) {
      return;
    }

    if (_selectedThemeIndex == index) {
      return;
    }

    _selectedThemeIndex = index;
    notifyListeners();
    await _themeService.saveThemeIndex(index);
  }

  Future<void> setThemeByName(String name) async {
    final index = indexOfThemeName(name);
    await setThemeIndex(index);
  }

  Future<void> _loadTheme() async {
    final index = await _themeService.loadThemeIndex();
    if (index < 0 || index >= presetThemes.length) {
      return;
    }

    _selectedThemeIndex = index;
    notifyListeners();
  }
}
