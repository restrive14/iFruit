import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/model/pageParams.dart';
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
  final List<Map<String, dynamic>> _messageRows = [];

  // 获取消息列表
  void _getMessageList() async {
    try {
      final res = await DbHelper.instance.queryAll('message');
      final result = res
          .map(
            (item) => MessageItem(
              id: item['id']?.toString() ?? '',
              avatar: item['avatar']?.toString() ?? '',
              title: item['title']?.toString() ?? '',
              content: item['content']?.toString() ?? '',
              time: item['time']?.toString() ?? '',
            ),
          )
          .toList();

      setState(() {
        _messageList = result;
        _messageRows.clear();
        _messageRows.addAll(res);
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

  Future<void> _onTapDel() async {
    if (_messageList.isEmpty ||
        _selectedIndex < 0 ||
        _selectedIndex >= _messageList.length) {
      return;
    }

    final id = _messageList[_selectedIndex].id;
    await DbHelper.instance.delete('message', where: 'id = ?', whereArgs: [id]);

    if (!mounted) return;
    _getMessageList();
    setState(() {
      _selectedIndex = 0;
    });
  }

  void _onTapPlus() {
    final id = _messageList[_selectedIndex].id;
    Navigator.pushNamed(
      context,
      '/messageDetail',
      arguments: PageParamsArgs(id: id.toString()),
    ).then((_) {
      _getMessageList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Scaffold(
      appBar: TopStatusBar(title: '短信'),
      body: _messageList.isNotEmpty
          ? ListView.builder(
              itemCount: _messageList.length,
              itemBuilder: (context, index) {
                final message = _messageList[index];
                final row = _messageRows[index];
                final isUnread = row['is_read'] == 0 || row['is_read'] == '0';
                return ListItemCell(
                  id: message.id,
                  title: message.title,
                  time: message.time,
                  showReadStatus: isUnread,
                  content: message.content,
                  selected: index == _selectedIndex,
                  onTap: () => _onTapSelectIcon(index),
                );
              },
            )
          : Center(child: Text('无消息', style: textStyle)),

      bottomNavigationBar: BottomBar(
        showDel: true,
        onTapDel: _onTapDel,
        onTapPlus: _onTapPlus,
      ),
    );
  }
}
