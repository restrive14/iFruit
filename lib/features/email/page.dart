import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/listItemCell.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/email/model.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  // 选中索引
  int _selectedIndex = 0;

  final List<EmailItem> _emailList = [];
  final List<Map<String, dynamic>> _emailRows = [];

  // 获取邮件列表
  void _getEmailList() async {
    try {
      final res = await DbHelper.instance.queryAll('email');
      final result = res
          .map(
            (item) => EmailItem(
              id: item['id']?.toString() ?? '',
              avatar: item['avatar']?.toString(),
              title: item['title']?.toString() ?? '',
              description: item['description']?.toString(),
              content: item['content']?.toString() ?? '',
              time: item['time']?.toString() ?? '',
            ),
          )
          .toList();

      setState(() {
        _emailList.clear();
        _emailList.addAll(result);
        _emailRows.clear();
        _emailRows.addAll(res);
      });
    } catch (e) {
      debugPrint('${e.toString()} 错误日志');
    }
  }

  @override
  void initState() {
    super.initState();
    _getEmailList();
  }

  // 点击图标选中
  void _onTapSelectIcon(int index) {
    AudioUtil().play(AudioSound.click);
    setState(() {
      _selectedIndex = index;
    });
  }

  // 点击左侧按钮删除
  void _onTapDel() {
    final id = _emailList[_selectedIndex].id;
  }

  void _onTapPlus() {
    final id = _emailList[_selectedIndex].id;
    Navigator.pushNamed(
      context,
      '/emailDetail',
      arguments: PageParamsArgs(id: id.toString()),
    ).then((_) {
      _getEmailList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Scaffold(
      appBar: TopStatusBar(title: '收件箱'),
      body: _emailList.isNotEmpty
          ? ListView.builder(
              itemCount: _emailList.length,
              itemBuilder: (context, index) {
                final email = _emailList[index];
                final row = _emailRows[index];
                final isUnread = row['is_read'] == 0 || row['is_read'] == '0';
                return ListItemCell(
                  id: email.id,
                  title: email.title,
                  content: email.description,
                  showReadStatus: isUnread,
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
