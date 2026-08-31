import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  final int backgroundIndex;

  const HomeBackground({super.key, this.backgroundIndex = 0});

  static const List<String> _backgroundAssets = [
    'assets/images/background/1.jpg',
    'assets/images/background/1.jpg',
    'assets/images/background/2.jpg',
    'assets/images/background/3.jpg',
    'assets/images/background/4.jpg',
    'assets/images/background/5.jpg',
    'assets/images/background/6.jpg',
    'assets/images/background/7.jpg',
    'assets/images/background/8.jpg',
    'assets/images/background/9.jpg',
    'assets/images/background/10.jpg',
    'assets/images/background/11.jpg',
    'assets/images/background/12.jpg',
    'assets/images/background/13.jpg',
    'assets/images/background/14.jpg',
    'assets/images/background/15.jpg',
  ];

  String get _assetPath {
    if (backgroundIndex < 0 || backgroundIndex >= _backgroundAssets.length) {
      return _backgroundAssets[0];
    }
    return _backgroundAssets[backgroundIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        _assetPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(color: const Color(0xFF0649EE));
        },
      ),
    );
  }
}
