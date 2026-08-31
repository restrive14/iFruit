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
    final titleStyle =
        Theme.of(context).textTheme.titleLarge ??
        TextStyle(color: Colors.white, fontSize: 24, height: 1.5);
    final textStyle =
        Theme.of(context).textTheme.bodyMedium ??
        TextStyle(color: Colors.white, fontSize: 16, height: 1.5);
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
            if (icon == null)
              Container(
                width: 25,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Center(
                  child: showReadStatus == true
                      ? Icon(Icons.circle, size: 13, color: textColor)
                      : Container(),
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
                        style: titleStyle.copyWith(
                          color: textColor,
                          textBaseline: TextBaseline.ideographic,
                        ),
                      ),
                      Text(
                        time ?? '',
                        style: textStyle.copyWith(color: textColor),
                      ),
                    ],
                  ),
                  if (content != null) ...[
                    Text(
                      content ?? '',
                      maxLines: 1,
                      style: textStyle.copyWith(
                        color: textColor,
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
