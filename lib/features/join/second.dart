import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/joinItemCell.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';

class SecondDetailPage extends StatefulWidget {
  final String joinId;

  const SecondDetailPage({super.key, required this.joinId});

  @override
  State<SecondDetailPage> createState() => _SecondDetailPageState();
}

class _SecondDetailPageState extends State<SecondDetailPage> {
  // 选中索引
  int _selectedIndex = 0;

  // 点击item选中
  void _onTapSelectIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
    AudioUtil().play(AudioSound.click);
  }

  // 是否确定
  bool _isConfirm = false;
  // 点击加号
  void onTapPlus() {
    if (_isConfirm) {
      Fluttertoast.showToast(msg: '正在匹配');
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
      return;
    }
    setState(() {
      _isConfirm = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '快速加入'),
      body: Container(
        child: _isConfirm
            ? JoinItemCell(
                icon: Icon(
                  Icons.check_box_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                id: '-1',
                title: '您是否确定？',
                selected: true,
                onTap: () => {},
              )
            : widget.joinId == '2'
            ? ListView(
                children: [
                  JoinItemCell(
                    id: '0',
                    title: '加入"待命"',
                    selected: 0 == _selectedIndex,
                    onTap: () => _onTapSelectIcon(0),
                  ),
                  JoinItemCell(
                    id: '1',
                    title: '通过大厅直接加入',
                    selected: 1 == _selectedIndex,
                    onTap: () => _onTapSelectIcon(1),
                  ),
                ],
              )
            : JoinItemCell(
                id: '-1',
                title: '独自',
                selected: true,
                onTap: () => {},
              ),
      ),
      bottomNavigationBar: BottomBar(
        centerIcon: Icon(Icons.check_rounded, color: Colors.green, size: 50),
        onTapPlus: onTapPlus,
      ),
    );
  }
}
