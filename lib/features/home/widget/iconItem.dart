import 'package:flutter/material.dart';
import 'package:ifruit/features/home/model.dart';
import 'package:ifruit/features/home/widget/badge.dart';

class HomeGridItem extends StatelessWidget {
  final IconItem feature;
  final bool selected;
  final VoidCallback onTap;

  const HomeGridItem({
    super.key,
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
                    top: 0,
                    left: 0,
                    child: IconBadge(
                      value: feature.badge!,
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
