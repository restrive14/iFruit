import 'package:flutter/material.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/joinItemCell.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/setting/model.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // 选中索引
  int _selectedIndex = 0;
  List<SettingItem> _settingList = [];

  // 获取设置选项列表
  void _getSettingList() async {
    try {
      setState(() {
        _settingList = [
          SettingItem(id: '1', name: '背景', icon: Icons.image),
          SettingItem(
            id: '2',
            name: '邀请声音',
            icon: Icons.record_voice_over_outlined,
          ),
          SettingItem(id: '3', name: '铃声', icon: Icons.notifications_none),
          SettingItem(
            id: '4',
            name: 'Snapmatic',
            icon: Icons.access_alarm_sharp,
          ),
          SettingItem(id: '5', name: '主题', icon: Icons.color_lens),
          SettingItem(id: '6', name: '振动', icon: Icons.vibration),
          SettingItem(id: '7', name: '字体', icon: Icons.font_download),
          SettingItem(id: '8', name: '重置数据', icon: Icons.clear),
          SettingItem(id: '9', name: '个人信息', icon: Icons.person),
        ];
      });
    } catch (e) {
      debugPrint('${e.toString()} 错误日志');
    }
  }

  @override
  void initState() {
    super.initState();
    _getSettingList();
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
    final title = _settingList[_selectedIndex].name;
    Navigator.pushNamed(
      context,
      '/settingDetail',
      arguments: SettingPageParamsArgs(id: id.toString(), title: title),
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
              setting.icon,
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
