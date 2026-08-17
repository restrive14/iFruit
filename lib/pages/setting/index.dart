import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/models/setting.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/joinItemCell.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // 选中索引
  int _selectedIndex = -1;
  List<SettingItem> _settingList = [];
  // 获取联系人列表
  void _getFriendList() async {
    try {
      final data = await rootBundle.loadString('assets/data/setting.json');
      final List<dynamic> rawArray = json.decode(data);
      List<SettingItem> result = rawArray
          .map((item) => SettingItem.fromJson(item))
          .toList();
      print('设置项列表: $result');
      setState(() {
        _settingList = result;
      });
    } catch (e) {
      debugPrint('${e.toString()} 错误日志');
    }
  }

  @override
  void initState() {
    super.initState();
    _getFriendList();
  }

  // 点击图标选中
  void _onTapSelectIcon(int index) {
    AudioUtil().play(AudioSound.click);
    setState(() {
      _selectedIndex = index;
    });
  }

  void onTapPlus() {
    final id = _settingList[_selectedIndex].id;
    Navigator.pushNamed(
      context,
      '/settingDetail',
      arguments: SettingDetailArgs(id: id.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '设置'),
      body: ListView.builder(
        itemCount: _settingList.length,
        itemBuilder: (context, index) {
          final setting = _settingList[index];
          return JoinItemCell(
            icon: Icon(
              Icons.vibration,
              size: 30,
              color: index == _selectedIndex ? Colors.white : Colors.black,
            ),
            id: index.toString(),
            title: setting.name,
            selected: index == _selectedIndex,
            onTap: () => _onTapSelectIcon(index),
          );
        },
      ),
      bottomNavigationBar: BottomBar(onTapPlus: onTapPlus),
    );
  }
}
