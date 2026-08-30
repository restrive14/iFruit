class MessageItem {
  final String id;
  final String avatar;
  final String title;
  final String content;
  final String time;

  const MessageItem({
    required this.id,
    required this.avatar,
    required this.title,
    required this.content,
    required this.time,
  });

  factory MessageItem.fromJson(Map<String, dynamic> json) {
    return MessageItem(
      id: json['id'],
      avatar: json['avatar'],
      title: json['title'],
      content: json['content'],
      time: json['time'],
    );
  }
}
