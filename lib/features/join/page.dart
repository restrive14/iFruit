import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/joinItemCell.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/join/model.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  // 选中索引
  int _selectedIndex = 0;

  List<JoinItem> _taskList = [];
  // 获取任务列表
  void _getTaskList() async {
    try {
      final data = await rootBundle.loadString('assets/data/join.json');
      final List<dynamic> rawArray = json.decode(data);
      List<JoinItem> result = rawArray
          .map((item) => JoinItem.fromJson(item))
          .toList();
      setState(() {
        _taskList = result;
      });
    } catch (e) {
      debugPrint('${e.toString()} 错误日志');
    }
  }

  @override
  void initState() {
    super.initState();
    _getTaskList();
  }

  // 点击图标选中
  void _onTapSelectIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
    AudioUtil().play(AudioSound.click);
  }

  void onTapPlus() {
    final id = _taskList[_selectedIndex].id;
    Navigator.pushNamed(
      context,
      '/joinDetail',
      arguments: PageParamsArgs(id: id.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '快速加入'),
      body: ListView.builder(
        itemCount: _taskList.length,
        itemBuilder: (context, index) {
          final taskitem = _taskList[index];
          return JoinItemCell(
            id: taskitem.id,
            title: taskitem.title,
            selected: index == _selectedIndex,
            onTap: () => _onTapSelectIcon(index),
          );
        },
      ),
      bottomNavigationBar: BottomBar(
        centerIcon: const Icon(
          Icons.check_rounded,
          color: Colors.green,
          size: 50,
        ),
        onTapPlus: onTapPlus,
      ),
    );
  }
}
