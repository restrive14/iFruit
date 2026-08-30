import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/club/model.dart';

class ClubDetailPage extends StatefulWidget {
  final String clubId;
  const ClubDetailPage({super.key, required this.clubId});

  @override
  State<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  ClubDetail? _clubInviteDetail;

  void _initData() {
    setState(() {
      _clubInviteDetail = ClubDetail(
        avatar: 'assets/icons/avatar/weizhi.webp',
        name: 'yyy',
        content:
            '想让你成为一名副手。\n -工资：\$10000 \n -副手：0 \n -游艇：有 \n -办公室：有 \n -仓库：2 \n -载具：10000 \n',
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void onTapPlus() {
    Fluttertoast.showToast(msg: '已接受邀请');
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyLarge ??
        TextStyle(fontSize: 16, height: 1.5, color: Colors.white);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TopStatusBar(title: '邀请'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(_clubInviteDetail!.avatar, width: 70, height: 70),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _clubInviteDetail!.name,
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                _clubInviteDetail!.content,
                style: textStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        centerIcon: Icon(Icons.check_rounded, color: Colors.green, size: 50),
        onTapPlus: onTapPlus,
      ),
    );
  }
}
