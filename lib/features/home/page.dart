import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/home/data.dart';
import 'package:ifruit/features/home/widget/background.dart';
import 'package:ifruit/features/home/widget/iconItem.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 选中索引
  int _selectedIndex = 0;

  Future<void> _loadUnreadCounts() async {
    try {
      final unreadEmail = await DbHelper.instance.countUnread('email');
      final unreadMessage = await DbHelper.instance.countUnread('message');
      final unreadTask = await DbHelper.instance.countUnread('task');
      final unreadClub = await DbHelper.instance.countUnread('club');

      if (!mounted) return;

      setState(() {
        HomeIconList[0].badge = unreadEmail > 0 ? unreadEmail : null;
        HomeIconList[1].badge = unreadMessage > 0 ? unreadMessage : null;
        HomeIconList[4].badge = unreadTask > 0 ? unreadTask : null;
        HomeIconList[8].badge = unreadClub > 0 ? unreadClub : null;
      });
    } catch (e) {
      debugPrint('loadUnreadCounts error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUnreadCounts();
  }

  // 点击图标选中
  void _onTapSelectIcon(int index) {
    AudioUtil().play(AudioSound.click);
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> takePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      // source: ImageSource.camera 相机；ImageSource.gallery相册
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80, // 图片压缩质量 0‑100
        maxWidth: 1080,
      );

      if (photo != null) {
        // photo.path 本地文件路径
        print("拍照成功：${photo.path}");
        // 显示图片 Image.file(File(photo.path!))
      } else {
        print("用户取消拍照");
      }
    } catch (e) {
      print(e);
    }
  }

  // 跳转页面
  void _openSelectedIcon() {
    final route = HomeIconList[_selectedIndex].route;
    if (route == '/camera') {
      takePhoto();
      return;
    }
    if (route != null) {
      Navigator.pushNamed(context, route).then((_) {
        _loadUnreadCounts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIcon = HomeIconList[_selectedIndex];

    return Scaffold(
      appBar: TopStatusBar(title: selectedIcon.name),
      body: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: BlueHomePainter())),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final horizontalPadding = 18.0;
              final gap = 12.0;
              final gridWidth = availableWidth - horizontalPadding * 2;
              final cellSize = (gridWidth - gap * 2) / 3;

              return Center(
                child: SizedBox(
                  width: availableWidth,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 12,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 18,
                          childAspectRatio: 1,
                        ),
                    itemCount: HomeIconList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: cellSize,
                        height: cellSize,
                        child: HomeGridItem(
                          feature: HomeIconList[index],
                          selected: index == _selectedIndex,
                          onTap: () => _onTapSelectIcon(index),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(onTapPlus: _openSelectedIcon),
    );
  }
}
