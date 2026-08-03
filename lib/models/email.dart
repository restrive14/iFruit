class EmailItem {
  final String id;
  final String? avatar;
  final String title;
  final String content;
  final String time;

  const EmailItem({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    this.avatar,
  });

  factory EmailItem.fromJson(Map<String, dynamic> json) {
    return EmailItem(
      id: json['id'],
      avatar: json['avatar'],
      title: json['title'],
      content: json['content'],
      time: json['time'],
    );
  }
}
