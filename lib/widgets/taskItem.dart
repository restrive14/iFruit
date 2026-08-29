import 'package:flutter/material.dart';

// 任务清单列表item组件
class TaskItemCell extends StatelessWidget {
  final String id;
  final String name;
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const TaskItemCell({
    super.key,
    required this.id,
    required this.name,
    required this.title,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titleStyle =
        Theme.of(context).textTheme.titleLarge ??
        TextStyle(color: Colors.white, fontSize: 24, height: 1.5);
    final textStyle =
        Theme.of(context).textTheme.bodyMedium ??
        TextStyle(color: Colors.white, fontSize: 16, height: 1.5);
    final bg = selected
        ? theme.primary
        : const Color.fromARGB(255, 191, 191, 191);
    final textColor = Colors.black;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: bg,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: const Color.fromARGB(255, 191, 191, 191),
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 10,
                constraints: const BoxConstraints(minHeight: 0),
                decoration: BoxDecoration(color: theme.primary),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? bg
                        : const Color.fromARGB(255, 193, 193, 193),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: titleStyle.copyWith(color: textColor)),
                      SizedBox(height: 10),
                      Text(
                        title,
                        style: textStyle.copyWith(
                          color: textColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
