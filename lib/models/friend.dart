class FriendItem {
  final String id;
  final String avatar;
  final String name;

  const FriendItem({
    required this.id,
    required this.avatar,
    required this.name,
  });

  factory FriendItem.fromJson(Map<String, dynamic> json) {
    return FriendItem(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
    );
  }
}
