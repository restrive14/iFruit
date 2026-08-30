import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/listItemCell.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/message/model.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  // 选中索引
  int _selectedIndex = 0;

  List<MessageItem> _messageList = [];
  // 获取消息列表
  void _getMessageList() async {
    try {
      final data = await rootBundle.loadString('assets/data/message.json');
      final List<dynamic> rawArray = json.decode(data);
      List<MessageItem> result = rawArray
          .map((item) => MessageItem.fromJson(item))
          .toList();
      setState(() {
        _messageList = result;
      });
    } catch (e) {
      debugPrint('${e.toString()} 错误日志');
    }
  }

  @override
  void initState() {
    super.initState();
    _getMessageList();
  }

  // 点击图标选中
  void _onTapSelectIcon(int index) {
    AudioUtil().play(AudioSound.click);
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapPlus() {
    final id = _messageList[_selectedIndex].id;
    Navigator.pushNamed(
      context,
      '/messageDetail',
      arguments: MessageDetailArgs(id: id.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '短信'),
      body: ListView.builder(
        itemCount: _messageList.length,
        itemBuilder: (context, index) {
          final message = _messageList[index];
          return ListItemCell(
            id: message.id,
            title: message.title,
            time: message.time,
            showReadStatus: true,
            content: message.content,
            selected: index == _selectedIndex,
            onTap: () => _onTapSelectIcon(index),
          );
        },
      ),
      bottomNavigationBar: BottomBar(showDel: true, onTapPlus: _onTapPlus),
    );
  }
}
