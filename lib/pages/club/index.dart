import 'package:flutter/material.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class _FriendItem {
  final String name;
  final IconData? icon;
  const _FriendItem({required this.name, this.icon});
}

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  // 选中索引
  int _selectedIndex = 1;
  // 图标列表
  static const List<_FriendItem> _friendList = [
    _FriendItem(name: '好友1', icon: Icons.person),
    _FriendItem(name: '好友1', icon: Icons.person),
    _FriendItem(name: '好友1', icon: Icons.person),
  ];

  // 点击图标选中
  void _onTapSelectIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '保镖事务所'),
      body: ListView.builder(
        itemCount: _friendList.length,
        itemBuilder: (context, index) {
          final friend = _friendList[index];
          return ListTile(
            leading: Icon(friend.icon),
            title: Text(friend.name),
            onTap: () => _onTapSelectIcon(index),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
