import 'package:flutter/material.dart';

// email/message/friend 列表页公用的列表项组件
class ListItemCell extends StatelessWidget {
  final String id;
  final String? icon;
  final String title;
  final bool? showReadStatus;
  final String? content;
  final String? time;
  final bool selected;
  final VoidCallback? onTap;

  const ListItemCell({
    super.key,
    this.icon,
    this.showReadStatus = false,
    required this.id,
    required this.title,
    this.content,
    this.time,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = selected ? colorScheme.primary : Colors.transparent;
    final textColor = selected ? Colors.white : Colors.black;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 4, top: 8, right: 4, bottom: 8),
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
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(icon!, width: 50, height: 50),
              ),
            if (showReadStatus == true)
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Icon(Icons.circle, size: 10, color: textColor),
                ),
              ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          textBaseline: TextBaseline.ideographic,
                        ),
                      ),
                      Text(
                        time ?? '',
                        style: TextStyle(color: textColor, fontSize: 20),
                      ),
                    ],
                  ),
                  if (content != null) ...[
                    SizedBox(height: 10),
                    Text(
                      content ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
