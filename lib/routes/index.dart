import 'package:flutter/material.dart';
import 'package:ifruit/pages/club/index.dart';
import 'package:ifruit/pages/email/index.dart';
import 'package:ifruit/pages/friend/index.dart';
import 'package:ifruit/pages/join/index.dart';
import 'package:ifruit/pages/message/index.dart';
import 'package:ifruit/pages/setting/index.dart';
import 'package:ifruit/pages/task/index.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/friend': (context) => const FriendPage(),
  '/setting': (context) => const SettingPage(),
  '/email': (context) => const EmailPage(),
  '/message': (context) => const MessagePage(),
  '/join': (context) => const JoinPage(),
  '/task': (context) => const TaskPage(),
  '/club': (context) => const ClubPage(),
};
