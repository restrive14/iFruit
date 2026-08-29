class AppSettings {
  /// 背景
  final int backgroundIndex;

  /// 邀请声音
  final int inviteSoundIndex;

  /// 铃声
  final int ringtoneIndex;

  /// Snapmatic
  final int snapmaticIndex;

  /// 主题
  final int themeIndex;

  /// 振动
  final int vibrationIndex;

  /// 字体
  final int fontIndex;

  const AppSettings({
    this.backgroundIndex = 0,
    this.inviteSoundIndex = 0,
    this.ringtoneIndex = 0,
    this.snapmaticIndex = 0,
    this.themeIndex = 0,
    this.vibrationIndex = 0,
    this.fontIndex = 1,
  });

  AppSettings copyWith({
    int? backgroundIndex,
    int? inviteSoundIndex,
    int? ringtoneIndex,
    int? snapmaticIndex,
    int? themeIndex,
    int? vibrationIndex,
    int? fontIndex,
  }) {
    return AppSettings(
      backgroundIndex: backgroundIndex ?? this.backgroundIndex,
      inviteSoundIndex: inviteSoundIndex ?? this.inviteSoundIndex,
      ringtoneIndex: ringtoneIndex ?? this.ringtoneIndex,
      snapmaticIndex: snapmaticIndex ?? this.snapmaticIndex,
      themeIndex: themeIndex ?? this.themeIndex,
      vibrationIndex: vibrationIndex ?? this.vibrationIndex,
      fontIndex: fontIndex ?? this.fontIndex,
    );
  }
}
