// 数据模型
import 'package:flutter/material.dart';

// 图标item
class IconItem {
  final String name;
  final IconData? icon;
  final String? assetIconPath;
  final int? badge;
  final String? route;

  const IconItem({
    required this.name,
    this.icon,
    this.assetIconPath,
    this.badge,
    this.route,
  });
}
