class JoinItem {
  final String id;
  final String title;
  final List<JoinItem>? subJoinList;

  const JoinItem({required this.id, required this.title, this.subJoinList});

  factory JoinItem.fromJson(Map<String, dynamic> json) {
    return JoinItem(
      id: json['id'],
      title: json['title'],
      subJoinList: (json['subJoinList'] as List?)
          ?.map((e) => JoinItem.fromJson(e))
          .toList(),
    );
  }
}
