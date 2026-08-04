import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/models/friend.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/listItemCell.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  // 选中索引
  int _selectedIndex = -1;

  List<FriendItem> _friendList = [];
  // 获取联系人列表
  void _getFriendList() async {
    try {
      final data = await rootBundle.loadString('assets/data/friend.json');
      final List<dynamic> rawArray = json.decode(data);
      List<FriendItem> result = rawArray
          .map((item) => FriendItem.fromJson(item))
          .toList();
      print('联系人列表: $result');
      setState(() {
        _friendList = result;
      });
    } catch (e) {
      debugPrint('${e.toString()} 错误日志');
    }
  }

  // 点击图标选中
  void _onTapSelectIcon(int index) {
    AudioUtil().play(AudioSound.click);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFriendList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '联系人'),
      body: ListView.builder(
        itemCount: _friendList.length,
        itemBuilder: (context, index) {
          final friend = _friendList[index];
          return ListItemCell(
            id: friend.id,
            title: friend.name,
            icon: friend.avatar,
            selected: index == _selectedIndex,
            onTap: () => _onTapSelectIcon(index),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(
        showDel: true,
        centerIcon: Icon(Icons.phone, color: Colors.green, size: 50),
      ),
    );
  }
}
