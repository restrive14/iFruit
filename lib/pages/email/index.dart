import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/models/email.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/listItemCell.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  // 选中索引
  int _selectedIndex = 0;

  List<EmailItem> _emailList = [];

  // 获取邮件列表
  void _getEmailList() async {
    try {
      final data = await rootBundle.loadString('assets/data/email.json');
      final List<dynamic> rawArray = json.decode(data);
      List<EmailItem> result = rawArray
          .map((item) => EmailItem.fromJson(item))
          .toList();
      print('邮件列表: $result');
      setState(() {
        _emailList = result;
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
      arguments: EmailDetailArgs(id: id.toString()),
    );
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
                return ListItemCell(
                  id: email.id,
                  title: email.title,
                  content: email.description,
                  showReadStatus: true,
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
