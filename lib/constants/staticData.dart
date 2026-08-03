// 数据模型
import 'package:flutter/material.dart';

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

class StaticData {
  static const List<IconItem> HomeIconList = [
    IconItem(
      name: '电子邮件',
      assetIconPath: 'assets/icons/email.webp',
      route: '/email',
    ),
    IconItem(
      name: '短信',
      assetIconPath: 'assets/icons/message.webp',
      route: '/message',
    ),
    IconItem(
      name: '联系人',
      assetIconPath: 'assets/icons/friend.webp',
      route: '/friend',
    ),
    IconItem(
      name: '快速加入',
      assetIconPath: 'assets/icons/join.webp',
      route: '/join',
    ),
    IconItem(
      name: '差事清单',
      assetIconPath: 'assets/icons/task.webp',
      route: '/task',
    ),
    IconItem(
      name: '设置',
      assetIconPath: 'assets/icons/setting.webp',
      route: '/setting',
    ),
    IconItem(
      name: 'Snapmatic',
      assetIconPath: 'assets/icons/camera.webp',
      route: '/camera',
    ),
    IconItem(
      name: '网络',
      assetIconPath: 'assets/icons/network.webp',
      route: '/network',
    ),
    IconItem(
      name: '保镖事务所',
      assetIconPath: 'assets/icons/club.webp',
      route: '/club',
    ),
  ]; // 首页图标列表数据
}
