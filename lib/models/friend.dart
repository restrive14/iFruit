class FriendItem {
  final String id; // 联系人id
  final String avatar; // 联系人头像
  final String name; // 联系人姓名
  final List<String>? audio; // 联系人本地的音频

  const FriendItem({
    required this.id,
    required this.avatar,
    required this.name,
    this.audio,
  });

  factory FriendItem.fromJson(Map<String, dynamic> json) {
    return FriendItem(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      audio: json['audio'],
    );
  }
}

class CallingArgs {
  final String id;
  CallingArgs({required this.id});
}
