import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/models/join.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/joinItemCell.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class JoinDetailPage extends StatefulWidget {
  final String joinId;

  const JoinDetailPage({super.key, required this.joinId});

  @override
  State<JoinDetailPage> createState() => _JoinDetailPageState();
}

class _JoinDetailPageState extends State<JoinDetailPage> {
  List<JoinItem> _joinData = [];
  // 选中索引
  int _selectedIndex = 0;
  // 点击图标选中
  void _onTapSelectIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
    AudioUtil().play(AudioSound.click);
  }

  Future<void> _getJoinList() async {
    try {
      final data = await rootBundle.loadString('assets/data/join.json');
      final List<dynamic> rawArray = json.decode(data);
      final List<JoinItem> result = rawArray
          .map((item) => JoinItem.fromJson(item))
          .toList();
      final selectedJoin = result.firstWhere(
        (join) => join.id == widget.joinId,
        orElse: () => const JoinItem(id: '', title: ''),
      );

      setState(() {
        _joinData = selectedJoin.subJoinList ?? [];
      });
    } catch (e) {
      debugPrint('Error loading Join data: $e');
      setState(() {
        _joinData = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getJoinList();
  }

  void onTapPlus() {
    Navigator.pushNamed(
      context,
      '/secondDetail',
      arguments: JoinDetailArgs(id: widget.joinId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '快速加入'),
      body: _joinData.isNotEmpty
          ? ListView.builder(
              itemCount: _joinData.length,
              itemBuilder: (context, index) {
                final taskitem = _joinData[index];
                return JoinItemCell(
                  id: taskitem.id,
                  title: taskitem.title,
                  selected: index == _selectedIndex,
                  onTap: () => _onTapSelectIcon(index),
                );
              },
            )
          : JoinItemCell(
              id: '-1',
              title: '独自',
              selected: true,
              onTap: () => {},
            ),
      bottomNavigationBar: BottomBar(
        centerIcon: Icon(Icons.check_rounded, color: Colors.green, size: 50),
        onTapPlus: onTapPlus,
      ),
    );
  }
}
