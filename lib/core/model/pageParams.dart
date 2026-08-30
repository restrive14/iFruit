class PageParamsArgs {
  final String id;
  PageParamsArgs({required this.id});
}

class SettingPageParamsArgs extends PageParamsArgs {
  final String title;
  SettingPageParamsArgs({required super.id, required this.title});
}
