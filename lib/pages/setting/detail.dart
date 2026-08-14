import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/models/setting.dart';
import 'package:ifruit/providers/theme.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/joinItemCell.dart';
import 'package:ifruit/widgets/topStatusBar.dart';
import 'package:provider/provider.dart';

class SettingDetailPage extends StatefulWidget {
  final String settingId;

  const SettingDetailPage({super.key, required this.settingId});

  @override
  State<SettingDetailPage> createState() => _SettingDetailPageState();
}

class _SettingDetailPageState extends State<SettingDetailPage> {
  List<SettingItem> _settingData = [];
  // 选中索引
  int _selectedIndex = -1;
  // 点击图标选中
  void _onTapSelectIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
    AudioUtil().play(AudioSound.click);
  }

  Future<void> _getSettingList() async {
    try {
      final data = await rootBundle.loadString('assets/data/setting.json');
      final List<dynamic> rawArray = json.decode(data);
      final List<SettingItem> result = rawArray
          .map((item) => SettingItem.fromJson(item))
          .toList();
      final selectedSetting = result.firstWhere(
        (setting) => setting.id == widget.settingId,
        orElse: () => const SettingItem(id: '', name: ''),
      );
      setState(() {
        _settingData = selectedSetting.subSettingList ?? [];
      });
    } catch (e) {
      debugPrint('Error loading Setting data: $e');
      setState(() {
        _settingData = [];
      });
    }
  }

  Future<void> onTapChangeTheme() async {
    if (_selectedIndex < 0 || _selectedIndex >= _settingData.length) {
      return;
    }

    final selectedTheme = _settingData[_selectedIndex];
    await context.read<ThemeProvider>().setThemeByName(selectedTheme.name);
  }

  @override
  void initState() {
    super.initState();
    _getSettingList();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: TopStatusBar(title: '主题'),
      body: _settingData.isNotEmpty
          ? ListView.builder(
              itemCount: _settingData.length,
              itemBuilder: (context, index) {
                final item = _settingData[index];
                final selected = _selectedIndex == -1
                    ? item.name == themeProvider.selectedThemeName
                    : index == _selectedIndex;

                return JoinItemCell(
                  id: item.id,
                  title: item.name,
                  selected: selected,
                  onTap: () => _onTapSelectIcon(index),
                );
              },
            )
          : JoinItemCell(id: '-1', title: '', selected: true, onTap: () => {}),
      bottomNavigationBar: BottomBar(onTapPlus: onTapChangeTheme),
    );
  }
}
