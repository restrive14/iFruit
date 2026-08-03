class TaskItem {
  final String id;
  final String avatar;
  final String title;
  final String content;

  const TaskItem({
    required this.id,
    required this.avatar,
    required this.title,
    required this.content,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'],
      avatar: json['avatar'],
      title: json['title'],
      content: json['content'],
    );
  }
}
