import 'package:flutter/material.dart';
import 'package:ifruit/features/club/index.dart';
import 'package:ifruit/features/email/index.dart';
import 'package:ifruit/features/friend/index.dart';
import 'package:ifruit/features/join/index.dart';
import 'package:ifruit/features/message/index.dart';
import 'package:ifruit/features/setting/index.dart';
import 'package:ifruit/features/task/index.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/friend': (context) => const FriendPage(),
  '/setting': (context) => const SettingPage(),
  '/email': (context) => const EmailPage(),
  '/message': (context) => const MessagePage(),
  '/join': (context) => const JoinPage(),
  '/task': (context) => const TaskPage(),
  '/club': (context) => const ClubPage(),
};
