import 'package:flutter/material.dart';
import 'package:ifruit/utils/audioplay.dart';

// 第一层的导航栏 中间加号 右侧返回
class BottomBarFirst extends StatelessWidget {
  final Function? onTapPlus;
  const BottomBarFirst({super.key, this.onTapPlus});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.5, 0.5, 1],
          colors: const [
            Color(0xFF171717),
            Color(0xFF171717),
            Color(0xFF000000),
            Color(0xFF000000),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  AudioUtil().play(AudioSound.back);
                  Navigator.maybePop(context);
                },
                child: Image.asset(
                  'assets/icons/delete.png',
                  width: 30,
                  height: 30,
                  color: Color.fromRGBO(1, 75, 130, 200),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: _BottomBarIcon(
                icon: Icon(Icons.add, color: const Color(0xFF6BDB9C), size: 48),
                onTap: () {
                  AudioUtil().play(AudioSound.confirm);
                  onTapPlus?.call();
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  AudioUtil().play(AudioSound.back);
                  Navigator.maybePop(context);
                },
                child: Image.asset(
                  'assets/icons/back.png',
                  width: 30,
                  height: 30,
                  color: Color.fromRGBO(255, 1, 1, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 第二层的导航栏 左侧搜索 中间logo 右侧返回
class BottomBarSecond extends StatelessWidget {
  const BottomBarSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: const Color(0xFF000000)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: _BottomBarIcon(
                icon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 128, 138, 147),
                  size: 36,
                ),
                onTap: () {
                  // 处理加号点击事件
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Image.asset(
                'assets/icons/logo.png',
                width: 30,
                height: 30,
                color: const Color.fromARGB(255, 128, 138, 147),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: _BottomBarIcon(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 128, 138, 147),
                  size: 36,
                ),
                onTap: () {
                  // 处理返回点击事件
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 图标
class _BottomBarIcon extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;

  const _BottomBarIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 28,
      splashColor: Colors.white12,
      highlightColor: Colors.white10,
      child: Padding(padding: const EdgeInsets.all(8.0), child: icon),
    );
  }
}

class BottomBar extends StatelessWidget {
  final Function? onTapPlus;
  const BottomBar({super.key, this.onTapPlus});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF000000)),
      height: MediaQuery.of(context).viewPadding.bottom + 180,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),
      child: Column(
        children: [
          Expanded(flex: 1, child: BottomBarFirst(onTapPlus: onTapPlus)),
          Expanded(flex: 1, child: BottomBarSecond()),
        ],
      ),
    );
  }
}
