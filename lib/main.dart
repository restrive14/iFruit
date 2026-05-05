import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 定义九个图标的数据，按要求顺序排列
  final List<IconData> gridIcons = [
    Icons.email, // 邮件
    Icons.message, // 信息
    Icons.contacts, // 联系人
    Icons.search, // 搜索
    Icons.done, // 待办
    Icons.navigation, // 导航
    Icons.camera_alt, // 相机
    Icons.language, // 因特网
    Icons.security, // 安保
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iFruit - 九宫格首页'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true, // 使标题居中显示
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3列
            crossAxisSpacing: 16.0, // 水平间距
            mainAxisSpacing: 16.0, // 垂直间距
            childAspectRatio: 1.0, // 宽高比
          ),
          itemCount: gridIcons.length,
          itemBuilder: (context, index) {
            return GridItem(icon: gridIcons[index]);
          },
        ),
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  final IconData icon;

  const GridItem({super.key, required this.icon});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        // 短暂延迟后恢复原始状态，使点击效果更明显
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
          }
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.green.shade200 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(widget.icon, size: 48, color: Colors.grey.shade700),
      ),
    );
  }
}
