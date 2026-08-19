import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

enum AudioSound { click, back, confirm, waiting, stoping, bell1, bell2, bell3 }

class AudioUtil {
  AudioUtil._internal();

  static final AudioUtil _instance = AudioUtil._internal();

  factory AudioUtil() => _instance;

  bool enable = true;

  final Map<AudioSound, AudioSource> _sources = {};

  final Map<AudioSound, String> _paths = const {
    AudioSound.click: "assets/audios/click.mp3",
    AudioSound.back: "assets/audios/return.mp3",
    AudioSound.confirm: "assets/audios/confirm.mp3",
    AudioSound.waiting: "assets/audios/phonewaiting.mp3",
    AudioSound.stoping: "assets/audios/phonestoping.mp3",
    AudioSound.bell1: "assets/audios/bell1.wav",
    AudioSound.bell2: "assets/audios/bell2.wav",
    AudioSound.bell3: "assets/audios/bell3.wav",
  };

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    try {
      await SoLoud.instance.init();

      SoLoud.instance.setGlobalVolume(1.0);

      for (final item in _paths.entries) {
        final source = await SoLoud.instance.loadAsset(item.value);
        _sources[item.key] = source;
      }

      _initialized = true;

      debugPrint("Audio 初始化完成");
    } catch (e) {
      debugPrint("Audio 初始化失败: $e");
    }
  }

  void play(AudioSound sound, {double volume = 1}) {
    if (!enable || !_initialized) return;

    final source = _sources[sound];

    if (source == null) return;

    SoLoud.instance.play(source, volume: volume);
  }

  SoundHandle? _loopHandle;

  Future<void> playLoop(AudioSound sound, {double volume = 1}) async {
    if (!enable || !_initialized) return;

    final source = _sources[sound];

    if (source == null) return;

    if (_loopHandle != null) {
      await SoLoud.instance.stop(_loopHandle!);
      _loopHandle = null;
    }

    _loopHandle = SoLoud.instance.play(source, volume: volume, looping: true);
  }

  Future<void> stopLoop() async {
    if (_loopHandle != null) {
      try {
        await SoLoud.instance.stop(_loopHandle!);
      } catch (_) {}
      _loopHandle = null;
    }
  }
}
