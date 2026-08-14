class SettingItem {
  final String id;
  final String name;
  final String? icon;
  final List<SettingItem>? subSettingList;

  const SettingItem({
    required this.id,
    required this.name,
    this.icon,
    this.subSettingList,
  });

  factory SettingItem.fromJson(Map<String, dynamic> json) {
    return SettingItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'],
      subSettingList:
          (json['subSettingList'] as List?)
              ?.map((e) => SettingItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SettingDetailArgs {
  final String id;
  SettingDetailArgs({required this.id});
}
