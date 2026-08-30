import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/taskItem.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/task/model.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // 选中索引
  int _selectedIndex = 0;

  List<TaskItem> _taskList = [];
  // 获取任务列表
  void _getTaskList() async {
    try {
      final data = await rootBundle.loadString('assets/data/task.json');
      final List<dynamic> rawArray = json.decode(data);
      List<TaskItem> result = rawArray
          .map((item) => TaskItem.fromJson(item))
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
    AudioUtil().play(AudioSound.click);
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapPlus() {
    final id = _taskList[_selectedIndex].id;
    Navigator.pushNamed(
      context,
      '/taskDetail',
      arguments: PageParamsArgs(id: id.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '差事清单'),
      body: ListView.builder(
        itemCount: _taskList.length,
        itemBuilder: (context, index) {
          final task = _taskList[index];
          return Padding(
            padding: EdgeInsetsGeometry.all(5),
            child: TaskItemCell(
              id: task.id,
              name: task.name,
              title: task.title,
              selected: index == _selectedIndex,
              onTap: () => _onTapSelectIcon(index),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBar(
        showDel: true,
        onTapPlus: _onTapPlus,
        centerIcon: const Icon(
          Icons.check_rounded,
          color: Colors.green,
          size: 50,
        ),
      ),
    );
  }
}
