class SettingItem {
  final String id;
  final String name;
  final String? icon;

  const SettingItem({required this.id, required this.name, this.icon});

  factory SettingItem.fromJson(Map<String, dynamic> json) {
    return SettingItem(id: json['id'], name: json['name'], icon: json['icon']);
  }
}
