import 'package:flutter/material.dart';
import 'package:ifruit/core/constants/staticData.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 选中索引
  int _selectedIndex = 0;

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
    final route = StaticData.HomeIconList[_selectedIndex].route;
    if (route == '/camera') {
      takePhoto();
      return;
    }
    if (route != null) {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIcon = StaticData.HomeIconList[_selectedIndex];

    return Scaffold(
      appBar: TopStatusBar(title: selectedIcon.name),
      body: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: _BlueHomePainter()),
          ),
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
                    itemCount: StaticData.HomeIconList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: cellSize,
                        height: cellSize,
                        child: _HomeGridItem(
                          feature: StaticData.HomeIconList[index],
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

class _HomeGridItem extends StatelessWidget {
  final IconItem feature;
  final bool selected;
  final VoidCallback onTap;

  const _HomeGridItem({
    required this.feature,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: selected ? 1.08 : 1,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final boxSize = constraints.maxWidth * 0.82;
            final iconSize = constraints.maxWidth * 0.56;

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOutCubic,
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x666A738C),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: feature.assetIconPath != null
                      ? Image.asset(
                          feature.assetIconPath!,
                          width: iconSize,
                          height: iconSize,
                        )
                      : Icon(feature.icon, size: iconSize),
                ),
                if (feature.badge != null)
                  Positioned(
                    top: -boxSize * 0.14,
                    right: -boxSize * 0.04,
                    child: _Badge(
                      value: feature.badge!,
                      size: constraints.maxWidth * 0.34,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final int value;
  final double size;

  const _Badge({required this.value, required this.size});

  @override
  Widget build(BuildContext context) {
    final fontSize = size * 0.6;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFE71945),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF50071A).withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        '$value',
        style: TextStyle(
          color: const Color(0xFFF7F1FF),
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}

class _BlueHomePainter extends CustomPainter {
  const _BlueHomePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = const Color(0xFF0649EE);
    canvas.drawRect(Offset.zero & size, base);

    final dark = Paint()
      ..color = const Color(0xFF043BD0).withValues(alpha: 0.5);
    final light = Paint()
      ..color = const Color(0xFF0D6CFF).withValues(alpha: 0.44);
    final mid = Paint()
      ..color = const Color(0xFF0757E7).withValues(alpha: 0.55);

    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.12)
        ..lineTo(size.width * 0.72, size.height * 0.05)
        ..lineTo(size.width * 0.58, size.height * 0.26)
        ..lineTo(0, size.height * 0.31)
        ..close(),
      light,
    );

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.32, size.height * 0.10)
        ..lineTo(size.width, size.height * 0.13)
        ..lineTo(size.width, size.height * 0.48)
        ..lineTo(size.width * 0.46, size.height * 0.38)
        ..close(),
      mid,
    );

    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.43)
        ..lineTo(size.width * 0.42, size.height * 0.36)
        ..lineTo(size.width * 0.56, size.height * 0.67)
        ..lineTo(0, size.height * 0.74)
        ..close(),
      dark,
    );

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.18, size.height)
        ..lineTo(size.width, size.height * 0.72)
        ..lineTo(size.width, size.height)
        ..close(),
      light,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
