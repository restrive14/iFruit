import 'package:flutter/material.dart';
import 'package:ifruit/constants/staticData.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

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

  // 跳转页面
  void _openSelectedIcon() {
    final route = StaticData.HomeIconList[_selectedIndex].route;
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
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 32,
                  childAspectRatio: 1,
                ),
                itemCount: StaticData.HomeIconList.length,
                itemBuilder: (context, index) {
                  return _HomeGridItem(
                    feature: StaticData.HomeIconList[index],
                    selected: index == _selectedIndex,
                    onTap: () => _onTapSelectIcon(index),
                  );
                },
              ),
            ),
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
        child: Center(
          child: SizedBox(
            width: 82,
            height: 82,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOutCubic,
                  width: 74,
                  height: 74,
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
                          width: 48,
                          height: 48,
                        )
                      : Icon(feature.icon, size: 48),
                ),
                if (feature.badge != null)
                  Positioned(
                    top: -10,
                    right: -2,
                    child: _Badge(value: feature.badge!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final int value;

  const _Badge({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
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
        style: const TextStyle(
          color: Color(0xFFF7F1FF),
          fontSize: 19,
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
