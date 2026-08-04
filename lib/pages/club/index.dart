import 'package:flutter/material.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  // 选中索引
  final int _selectedIndex = 1;

  // 点击图标选中
  void _onTapSelectIcon(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '保镖事务所'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 209, 133, 108),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('没有邀请', style: TextStyle(fontSize: 25)),
                  Text('可以进行', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        showDel: true,
        centerIcon: Icon(Icons.check_rounded, color: Colors.green, size: 50),
        onTapPlus: () {},
      ),
    );
  }
}
