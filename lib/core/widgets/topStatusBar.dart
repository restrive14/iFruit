import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ifruit/core/widgets/topTitleBar.dart';

class TopStatusBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showTitle;
  const TopStatusBar({super.key, this.title, this.showTitle = true});

  @override
  Size get preferredSize => Size.fromHeight(showTitle == true ? 110 : 60);

  @override
  State<TopStatusBar> createState() => _TopStatusBarState();
}

class _TopStatusBarState extends State<TopStatusBar> {
  String _timeStr = ""; // 当前时间字符串
  String _weekdayStr = ""; // 当前星期字符串
  late Timer _timer; // 计时器

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    final weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    setState(() {
      _timeStr =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      _weekdayStr = weekdays[now.weekday - 1];
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;
    final contentHeight = widget.showTitle == true ? 110.0 : 60.0;
    final textStyle =
        Theme.of(context).textTheme.bodySmall ??
        TextStyle(color: Colors.white, fontSize: 16, height: 1.5);
    return Container(
      height: topPadding + contentHeight,
      padding: EdgeInsets.only(top: topPadding),
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icons/logo.png',
                  width: 15,
                  height: 15,
                  color: Color.fromARGB(255, 128, 138, 147),
                ),
                const SizedBox(width: 2),
                Text(
                  'iFruit',
                  style: textStyle.copyWith(
                    color: Color.fromARGB(255, 128, 138, 147),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, color: Colors.white),
                      const SizedBox(width: 4),
                      Image.asset(
                        'assets/images/icons/point.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _weekdayStr,
                        style: textStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Text(
                      _timeStr,
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Transform.rotate(
                    angle: 3.14159 / 2, // 180 degrees in radians
                    child: Icon(Icons.battery_full, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          widget.showTitle == true
              ? SizedBox(height: 50, child: TopTitleBar(title: widget.title))
              : Container(),
        ],
      ),
    );
  }
}
