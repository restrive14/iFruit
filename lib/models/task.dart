class TaskItem {
  final String id;
  final String avatar;
  final String name;
  final String title;
  final String content;

  const TaskItem({
    required this.id,
    required this.name,
    required this.avatar,
    required this.title,
    required this.content,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      title: json['title'],
      content: json['content'],
    );
  }
}

class TaskDetailArgs {
  final String id;
  TaskDetailArgs({required this.id});
}
