import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ifruit/constants/friendData.dart';
import 'package:ifruit/models/friend.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class CallingPage extends StatefulWidget {
  final String id;
  const CallingPage({super.key, required this.id});

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  late FriendItem _friendDetail;
  final bool _isConnect = false; // 是否在通话中
  Timer? _loopTimer;
  void _initData() {
    final list = FriendData.list;
    final result = list.firstWhere((element) => element.id == widget.id);
    setState(() {
      _friendDetail = result;
    });
  }

  // 定时播放音频
  void _playAudio() {
    AudioUtil().play(AudioSound.stoping);
    _loopTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      AudioUtil().play(AudioSound.stoping);
    });
  }

  void _stopAudio() {
    _loopTimer?.cancel();
    _loopTimer = null;
  }

  @override
  void initState() {
    super.initState();
    _initData();
    _playAudio();
  }

  @override
  void dispose() {
    super.dispose();
    _stopAudio();
  }

  void onTapCancel() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.titleLarge ??
        TextStyle(fontSize: 24, color: Colors.white, height: 1.5);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TopStatusBar(showTitle: false),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              color: const Color(0xff000000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  Text(
                    _friendDetail.name,
                    style: titleStyle.copyWith(color: Colors.white),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Image.asset(
                        _friendDetail.avatar,
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        _isConnect ? '已接通' : '正在拨号......',
                        style: titleStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xFF28292b),
                child: Center(
                  child: Image.asset(
                    'assets/icons/logo.png',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        showPlus: false,
        rightIcon: Icon(Icons.call_end, color: Colors.red, size: 50),
      ),
    );
  }
}
