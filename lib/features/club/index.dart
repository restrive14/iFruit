import 'package:flutter/material.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/club/model.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  // 选中索引
  final int _selectedIndex = 1;

  ClubDetail _clubInviteDetail = ClubDetail(
    avatar: '',
    content: '',
    name: 'yyy',
  );

  // 点击图标选中
  void _onTapSelectIcon(int index) {}

  void onTapDel() {
    setState(() {
      _clubInviteDetail = ClubDetail(avatar: '', content: '', name: '');
    });
  }

  void onTapPlus() {
    if (_clubInviteDetail.name == '') {
      return;
    }
    Navigator.pushNamed(
      context,
      '/clubDetail',
      arguments: PageParamsArgs(id: '1'),
    );
  }

  void _initData() {
    setState(() {
      _clubInviteDetail = ClubDetail(avatar: '', content: '', name: 'yyy');
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final textStyle = Theme.of(context).textTheme.bodyMedium;
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
                  Text(
                    _clubInviteDetail.name != ''
                        ? _clubInviteDetail.name
                        : '无VIP邀请',
                    style: titleStyle,
                  ),
                  Text(
                    _clubInviteDetail.name != '' ? '想让你成为一名副手' : '',
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        showDel: _clubInviteDetail.name != '',
        showPlus: _clubInviteDetail.name != '',
        onTapDel: onTapDel,
        centerIcon: Icon(Icons.check_rounded, color: Colors.green, size: 50),
        onTapPlus: onTapPlus,
      ),
    );
  }
}
