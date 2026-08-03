import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ifruit/widgets/topTitleBar.dart';

class TopStatusBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const TopStatusBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(120);

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
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 120,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  width: 15,
                  height: 15,
                  color: Color.fromARGB(255, 128, 138, 147),
                ),
                const SizedBox(width: 2),
                Text(
                  'ifruit',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 128, 138, 147),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
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
                        'assets/icons/point.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _weekdayStr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Text(
                      _timeStr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
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
          Expanded(flex: 3, child: TopTitleBar(title: widget.title)),
        ],
      ),
    );
  }
}
