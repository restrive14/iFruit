import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifruit/models/setting.dart';
import 'package:ifruit/providers/global.dart';
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
  String title = ''; // 当前设置页标题
  List<SettingItem> _settingData = []; // 设置项列表
  int _selectedIndex = 0; // 当前选中的索引

  // 点击设置项
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

      final settingList = selectedSetting.subSettingList ?? [];
      // 从状态管理中获取保存的索引
      final savedIndex = context.read<GlobalProvider>().getSettingIndex(
        widget.settingId,
      );

      setState(() {
        _settingData = settingList;
        title = selectedSetting.name;
        _selectedIndex = savedIndex;
      });
    } catch (e) {
      debugPrint('Error loading Setting data: $e');
      setState(() {
        _settingData = [];
        _selectedIndex = 0;
      });
    }
  }

  Future<void> onTapChangeSetting() async {
    if (_selectedIndex < 0 || _selectedIndex >= _settingData.length) {
      return;
    }

    await context.read<GlobalProvider>().setSettingIndex(
      widget.settingId,
      _selectedIndex,
    );

    if (widget.settingId == '5') {
      final selectedTheme = _settingData[_selectedIndex];
      await context.read<ThemeProvider>().setThemeByName(selectedTheme.name);
    }

    Fluttertoast.showToast(msg: '修改成功');
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _getSettingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: title),
      body: _settingData.isNotEmpty
          ? ListView.builder(
              itemCount: _settingData.length,
              itemBuilder: (context, index) {
                final item = _settingData[index];
                final selected = index == _selectedIndex;

                return JoinItemCell(
                  icon: Icon(
                    Icons.edit_calendar_sharp,
                    size: 30,
                    color: index == _selectedIndex
                        ? Colors.white
                        : Colors.black,
                  ),
                  id: item.id,
                  title: item.name,
                  selected: selected,
                  onTap: () => _onTapSelectIcon(index),
                );
              },
            )
          : JoinItemCell(id: '-1', title: '', selected: true, onTap: () => {}),
      bottomNavigationBar: BottomBar(onTapPlus: onTapChangeSetting),
    );
  }
}
