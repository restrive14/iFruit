import 'package:flutter/material.dart';
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
  final String id;
  final String title;

  const SettingDetailPage({super.key, required this.id, required this.title});

  @override
  State<SettingDetailPage> createState() => _SettingDetailPageState();
}

class _SettingDetailPageState extends State<SettingDetailPage> {
  // 背景设置选项列表
  static final BGSettingList = [
    SettingItem(id: '1', name: '帮会徽章', icon: Icons.image),
    SettingItem(id: '2', name: '蓝色斜角', icon: Icons.image),
    SettingItem(id: '3', name: '蓝色碎片', icon: Icons.image),
    SettingItem(id: '4', name: '蓝色光圈', icon: Icons.image),
    SettingItem(id: '5', name: '钻石', icon: Icons.image),
    SettingItem(id: '6', name: '绿色荧光', icon: Icons.image),
    SettingItem(id: '7', name: '绿色碎片', icon: Icons.image),
    SettingItem(id: '8', name: '绿色方格', icon: Icons.image),
    SettingItem(id: '9', name: '绿色三角', icon: Icons.image),
    SettingItem(id: '10', name: '橙色8位', icon: Icons.image),
    SettingItem(id: '11', name: '橙色网格', icon: Icons.image),
    SettingItem(id: '12', name: '橙色方格', icon: Icons.image),
    SettingItem(id: '13', name: '橙色人字形', icon: Icons.image),
    SettingItem(id: '14', name: '橙色三角', icon: Icons.image),
    SettingItem(id: '15', name: '紫色荧光', icon: Icons.image),
    SettingItem(id: '16', name: '紫色格子', icon: Icons.image),
  ];
  // 邀请声音 / 振动 设置选项列表
  static final InviteSettingList = [
    SettingItem(id: '1', name: '开启', icon: Icons.lock_open),
    SettingItem(id: '2', name: '关闭', icon: Icons.lock),
  ];
  // 铃声设置选项列表
  static final BellSettingList = [
    SettingItem(id: '1', name: '铃声1', icon: Icons.notifications_none_outlined),
    SettingItem(id: '2', name: '铃声2', icon: Icons.notifications_none_outlined),
    SettingItem(id: '3', name: '铃声3', icon: Icons.notifications_none_outlined),
    SettingItem(id: '4', name: '静音', icon: Icons.notifications_off),
  ];
  // Snapmatic设置选项列表
  static final QuickSettingList = [
    SettingItem(id: '1', name: '快速启动开启', icon: Icons.lock_open),
    SettingItem(id: '2', name: '快速启动关闭', icon: Icons.lock),
  ];
  // 主题设置选项列表
  static final ThemeSettingList = [
    SettingItem(id: '1', name: '蓝色', icon: Icons.color_lens),
    SettingItem(id: '2', name: '绿色', icon: Icons.color_lens),
    SettingItem(id: '3', name: '灰色', icon: Icons.color_lens),
    SettingItem(id: '4', name: '橙色', icon: Icons.color_lens),
    SettingItem(id: '5', name: '粉色', icon: Icons.color_lens),
    SettingItem(id: '6', name: '紫色', icon: Icons.color_lens),
    SettingItem(id: '7', name: '红色', icon: Icons.color_lens),
  ];

  String title = ''; // 当前设置页标题
  List<SettingItem> _settingData = []; // 设置项列表
  int _selectedIndex = 0; // 当前选中的索引

  // 点击设置项
  void _onTapSelectIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
    AudioUtil().play(AudioSound.click);
    if (widget.id == '3') {
      switch (index) {
        case 0:
          AudioUtil().play(AudioSound.bell1);
          break;
        case 1:
          AudioUtil().play(AudioSound.bell2);
          break;
        case 2:
          AudioUtil().play(AudioSound.bell3);
          break;
      }
    }
  }

  Future<void> _getSettingList() async {
    try {
      late List<SettingItem> settingList;
      switch (widget.id) {
        case '1':
          settingList = BGSettingList;
          break;
        case '2':
          settingList = InviteSettingList;
          break;
        case '3':
          settingList = BellSettingList;
          break;
        case '4':
          settingList = QuickSettingList;
          break;
        case '5':
          settingList = ThemeSettingList;
          break;
        case '6':
          settingList = InviteSettingList;
          break;
      }
      // 从状态管理中获取保存的索引
      final savedIndex = context.read<GlobalProvider>().getSettingIndex(
        widget.id,
      );

      setState(() {
        _settingData = settingList;
        title = widget.title;
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

  // 设置背景
  void onTapSetBackground() {}
  // 设置铃声
  void onTapSetBell() {}
  // 设置主题
  void onTapSetTheme() async {
    final selectedTheme = _settingData[_selectedIndex];
    await context.read<ThemeProvider>().setThemeByName(selectedTheme.name);
  }

  // 设置振动
  void onTapSetVibrate() {}

  // 点击底部加号改变设置
  Future<void> onTapChangeSetting() async {
    if (_selectedIndex < 0 || _selectedIndex >= _settingData.length) {
      return;
    }

    await context.read<GlobalProvider>().setSettingIndex(
      widget.id,
      _selectedIndex,
    );

    switch (widget.id) {
      case '1':
        onTapSetBackground();
        break;
      case '2':
        break;
      case '3':
        onTapSetBell();
        break;
      case '4':
        break;
      case '5':
        onTapSetTheme();
        break;
      case '6':
        break;
      default:
        break;
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
                    item.icon,
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
