import 'package:flutter/material.dart';
import 'package:ifruit/core/constants/friendData.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/listItemCell.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/friend/model.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  // 选中索引
  int _selectedIndex = 0;

  List<FriendItem> _friendList = [];
  // 获取联系人列表
  void _getFriendList() async {
    try {
      final result = FriendData.list;
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

  // 点击中间图标
  void onTapPlus() {
    final id = _friendList[_selectedIndex].id;
    Navigator.pushNamed(context, '/calling', arguments: PageParamsArgs(id: id));
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
      bottomNavigationBar: BottomBar(
        showDel: true,
        centerIcon: const Icon(Icons.phone, color: Colors.green, size: 50),
        onTapPlus: onTapPlus,
      ),
    );
  }
}
