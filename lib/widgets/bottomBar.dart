import 'package:flutter/material.dart';
import 'package:ifruit/utils/audioplay.dart';

// 第一层的导航栏 中间加号 右侧返回
class BottomBarFirst extends StatelessWidget {
  final bool? showDel; // 是否展示左侧的删除按钮
  final Function? onTapDel; // 左侧图标的点击事件
  final bool? showPlus; // 是否展示中间的加号按钮
  final Icon? centerIcon; // 中间的自定义图标
  final Icon? rightIcon; // 右侧的自定义图标
  final Function? onTapPlus; // 中间图标的点击事件
  const BottomBarFirst({
    super.key,
    this.onTapPlus,
    this.showDel = false,
    this.onTapDel,
    this.showPlus = true,
    this.centerIcon,
    this.rightIcon,
  });

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
            Color(0xFF181a1b),
            Color(0xFF181a1b),
            Color(0xFF000000),
            Color(0xFF000000),
          ],
        ),
        border: Border(
          top: BorderSide(color: const Color(0xB3FFFFFF), width: 0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: showDel == true
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        AudioUtil().play(AudioSound.back);
                        onTapDel?.call();
                      },
                      child: Image.asset(
                        'assets/icons/delete.png',
                        width: 40,
                        height: 40,
                        color: Color.fromRGBO(1, 75, 130, 200),
                      ),
                    ),
                  )
                : Container(),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(color: const Color(0xFF444446)),
                  ),
                ),
                child: showPlus == true
                    ? Center(
                        child: _BottomBarIcon(
                          icon:
                              centerIcon ??
                              Icon(
                                Icons.add,
                                color: const Color(0xFF6BDB9C),
                                size: 60,
                              ),
                          onTap: () {
                            AudioUtil().play(AudioSound.confirm);
                            onTapPlus?.call();
                          },
                        ),
                      )
                    : Container(),
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
                  width: 40,
                  height: 40,
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
      child: icon,
    );
  }
}

class BottomBar extends StatelessWidget {
  final bool? showDel; // 是否展示左侧的删除按钮
  final bool? showPlus; // 是否展示中间的加号按钮
  final Icon? centerIcon; // 中间的自定义图标
  final Icon? rightIcon; // 右侧的自定义图标
  final Function? onTapPlus; // 中间按钮点击事件
  final Function? onTapDel; // 左侧按钮点击事件
  const BottomBar({
    super.key,
    this.onTapPlus,
    this.onTapDel,
    this.showDel = false,
    this.showPlus = true,
    this.centerIcon,
    this.rightIcon,
  });
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
          Expanded(
            flex: 1,
            child: BottomBarFirst(
              showDel: showDel,
              showPlus: showPlus,
              centerIcon: centerIcon,
              rightIcon: rightIcon,
              onTapDel: onTapDel,
              onTapPlus: onTapPlus,
            ),
          ),
          Expanded(flex: 1, child: BottomBarSecond()),
        ],
      ),
    );
  }
}
