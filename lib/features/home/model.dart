// 数据模型
import 'package:flutter/material.dart';

// 图标item
class IconItem {
  final String name;
  final IconData? icon;
  final String? assetIconPath;
  int? badge;
  final String? route;

  IconItem({
    required this.name,
    this.icon,
    this.assetIconPath,
    this.badge,
    this.route,
  });
}
