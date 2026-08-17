import 'package:flutter/material.dart';

// join/setting 列表页公用的列表项组件
class JoinItemCell extends StatelessWidget {
  final String id;
  final Widget? icon;
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const JoinItemCell({
    super.key,
    this.icon,
    required this.id,
    required this.title,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final bg = selected ? theme.primary : Colors.transparent;
    final textColor = selected ? Colors.white : Colors.black;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          left: 10,
          top: 15,
          right: 10,
          bottom: 15,
        ),
        decoration: BoxDecoration(
          color: bg,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: const Color.fromARGB(255, 191, 191, 191),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Padding(padding: const EdgeInsets.only(right: 10.0), child: icon),
            ],
            Text(title, style: TextStyle(color: textColor, fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
