import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
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
      final res = await DbHelper.instance.queryAll('task');
      final result = res
          .map(
            (item) => TaskItem(
              id: item['id']?.toString() ?? '',
              avatar: item['avatar']?.toString() ?? '',
              name: item['name']?.toString() ?? '',
              title: item['title']?.toString() ?? '',
              content: item['content']?.toString() ?? '',
            ),
          )
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

  Future<void> _onTapDel() async {
    if (_taskList.isEmpty) {
      return;
    }

    if (_selectedIndex < 0 || _selectedIndex >= _taskList.length) {
      return;
    }

    final id = _taskList[_selectedIndex].id;
    await DbHelper.instance.delete('task', where: 'id = ?', whereArgs: [id]);

    if (!mounted) return;
    _getTaskList();
    setState(() {
      _selectedIndex = 0;
    });
  }

  void _onTapPlus() {
    final id = _taskList[_selectedIndex].id;
    Navigator.pushNamed(
      context,
      '/taskDetail',
      arguments: PageParamsArgs(id: id.toString()),
    ).then((_) {
      _getTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final emptyPlaceholder = TaskItemCell(
      id: 'empty',
      name: '没有差事',
      title: '可以进行',
      selected: true,
      onTap: () {},
    );

    return Scaffold(
      appBar: TopStatusBar(title: '差事清单'),
      body: _taskList.isEmpty
          ? Padding(padding: const EdgeInsets.all(5), child: emptyPlaceholder)
          : ListView.builder(
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
        onTapDel: _onTapDel,
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
