import 'package:flutter/material.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/features/club/detail.dart';
import 'package:ifruit/features/club/page.dart';
import 'package:ifruit/features/email/detail.dart';
import 'package:ifruit/features/email/page.dart';
import 'package:ifruit/features/friend/calling.dart';
import 'package:ifruit/features/friend/page.dart';
import 'package:ifruit/features/join/detail.dart';
import 'package:ifruit/features/join/page.dart';
import 'package:ifruit/features/join/second.dart';
import 'package:ifruit/features/message/detail.dart';
import 'package:ifruit/features/message/page.dart';
import 'package:ifruit/features/setting/detail.dart';
import 'package:ifruit/features/setting/page.dart';
import 'package:ifruit/features/task/detail.dart';
import 'package:ifruit/features/task/page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/friend': (context) => const FriendPage(),
  '/setting': (context) => const SettingPage(),
  '/email': (context) => const EmailPage(),
  '/message': (context) => const MessagePage(),
  '/join': (context) => const JoinPage(),
  '/task': (context) => const TaskPage(),
  '/club': (context) => const ClubPage(),
};

PageRouteBuilder<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/messageDetail':
      final args = settings.arguments as PageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => MessageDetailPage(messageId: args.id),
      );
    case '/emailDetail':
      final args = settings.arguments as PageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => EmailDetailPage(emailId: args.id),
      );
    case '/joinDetail':
      final args = settings.arguments as PageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => JoinDetailPage(joinId: args.id),
      );
    case '/secondDetail':
      final args = settings.arguments as PageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => SecondDetailPage(joinId: args.id),
      );
    case '/taskDetail':
      final args = settings.arguments as PageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => TaskDetailPage(taskId: args.id),
      );
    case '/settingDetail':
      final args = settings.arguments as SettingPageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) =>
            SettingDetailPage(id: args.id, title: args.title),
      );
    case '/clubDetail':
      final args = settings.arguments as PageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => ClubDetailPage(clubId: args.id),
      );
    case '/calling':
      final args = settings.arguments as PageParamsArgs;
      return PageRouteBuilder(
        pageBuilder: (_, _, _) => CallingPage(id: args.id),
      );
  }
  return null;
}
