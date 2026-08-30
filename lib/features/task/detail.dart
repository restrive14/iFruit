import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/task/model.dart';

class TaskDetailPage extends StatefulWidget {
  final String taskId;

  const TaskDetailPage({super.key, required this.taskId});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TaskItem? _taskData;

  @override
  void initState() {
    super.initState();
    _loadMessage();
  }

  Future<void> _loadMessage() async {
    try {
      final data = await rootBundle.loadString('assets/data/task.json');
      final List<dynamic> rawArray = json.decode(data);
      final List<TaskItem> result = rawArray
          .map((item) => TaskItem.fromJson(item))
          .toList();
      _taskData = result.firstWhere((task) => task.id == widget.taskId);
      setState(() {});
    } catch (e) {
      debugPrint('Error loading message data: $e');
    }
  }

  void onTapPlus() {
    Fluttertoast.showToast(msg: '已接受邀请');
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Scaffold(
      appBar: TopStatusBar(title: '邀请'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (_taskData?.avatar != null && _taskData!.avatar.isNotEmpty)
                    ? Image.asset(_taskData!.avatar, width: 70, height: 70)
                    : Container(),
                const SizedBox(width: 10),
                Expanded(child: Text(_taskData?.name ?? '', style: textStyle)),
              ],
            ),
            const SizedBox(height: 15),
            Text(_taskData?.content ?? '', style: textStyle),
          ],
        ),
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
