import 'package:flutter/material.dart';

// 任务清单列表item组件
class TaskItemCell extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final bool selected;
  final VoidCallback? onTap;

  const TaskItemCell({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? const Color.fromARGB(255, 31, 126, 29)
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 31, 126, 29),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color.fromARGB(255, 31, 126, 29)
                        : const Color.fromARGB(255, 193, 193, 193),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: textColor, fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        content,
                        style: TextStyle(
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
