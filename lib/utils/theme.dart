import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _keyThemeIndex = 'themeIndex';

  // 保存主题索引
  Future<void> saveThemeIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeIndex, index);
  }

  // 读取主题索引
  Future<int> loadThemeIndex() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(_keyThemeIndex) ?? 0;
  }
}

class AppThemeConfig {
  final String name; // 主题名称
  final Color primaryColor; // 主色
  final Color textColor; // 文字颜色
  final double fontSize; // 基础文字大小
  final Color dividerColor; // 线条颜色

  const AppThemeConfig({
    required this.name,
    required this.primaryColor,
    required this.textColor,
    required this.fontSize,
    required this.dividerColor,
  });
}

ThemeData buildTheme(AppThemeConfig config) {
  // 根据主色生成 ColorScheme（自动计算亮暗色变体）
  final colorScheme = ColorScheme.fromSeed(
    seedColor: config.primaryColor,
    brightness: config.textColor == Colors.white
        ? Brightness.dark
        : Brightness.light,
  ).copyWith(primary: config.primaryColor);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    dividerColor: config.dividerColor,
    pageTransitionsTheme: PageTransitionsTheme(builders: {}),
    textTheme: TextTheme(
      // 这里统一设置基础文字大小，你可以根据需要调整各层级
      bodyMedium: TextStyle(fontSize: config.fontSize, color: config.textColor),
      bodyLarge: TextStyle(
        fontSize: config.fontSize * 1.25,
        color: config.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: config.fontSize * 1.5,
        color: config.textColor,
      ),
      // 其他层级按需添加...
    ),
    // 也可以设置 appBarTheme 等，继承 colorScheme
  );
}

final List<AppThemeConfig> presetThemes = [
  AppThemeConfig(
    name: '蓝色',
    primaryColor: const Color(0xFF4a88d5), // 蓝色
    textColor: Colors.black,
    fontSize: 16,
    dividerColor: const Color(0xFFcccccc),
  ),
  AppThemeConfig(
    name: '红色',
    primaryColor: const Color(0xFFad1900), // 红色
    textColor: Colors.black,
    fontSize: 16,
    dividerColor: const Color(0xFFcccccc),
  ),
  AppThemeConfig(
    name: '粉色',
    primaryColor: const Color(0xFFcb70a5), // 粉色
    textColor: Colors.black,
    fontSize: 16,
    dividerColor: const Color(0xFFcccccc),
  ),
  AppThemeConfig(
    name: '橙色',
    primaryColor: const Color(0xFFcc851f), // 橙色
    textColor: Colors.black,
    fontSize: 16,
    dividerColor: const Color(0xFFcccccc),
  ),
  AppThemeConfig(
    name: '绿色',
    primaryColor: const Color(0xFF217a00), // 绿色
    textColor: Colors.black,
    fontSize: 16,
    dividerColor: const Color(0xFFcccccc),
  ),
  AppThemeConfig(
    name: '紫色',
    primaryColor: const Color(0xFFa473b7), // 紫色
    textColor: Colors.black,
    fontSize: 16,
    dividerColor: const Color(0xFFcccccc),
  ),
  AppThemeConfig(
    name: '灰色',
    primaryColor: const Color(0xFF6e7370), // 灰色
    textColor: Colors.black,
    fontSize: 16,
    dividerColor: const Color(0xFFcccccc),
  ),
];
