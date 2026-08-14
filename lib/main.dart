import 'package:flutter/material.dart';
import 'package:ifruit/models/email.dart';
import 'package:ifruit/models/join.dart';
import 'package:ifruit/models/message.dart';
import 'package:ifruit/models/setting.dart';
import 'package:ifruit/models/task.dart';
import 'package:ifruit/pages/email/detail.dart';
import 'package:ifruit/pages/home/index.dart';
import 'package:ifruit/pages/join/detail.dart';
import 'package:ifruit/pages/message/detail.dart';
import 'package:ifruit/pages/setting/detail.dart';
import 'package:ifruit/pages/task/detail.dart';
import 'package:ifruit/providers/global.dart';
import 'package:ifruit/providers/theme.dart';
import 'package:ifruit/routes/index.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:ifruit/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AudioUtil().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(ThemeService())),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ifruit',
      theme: theme.themeData,
      home: const HomePage(),
      routes: appRoutes,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/messageDetail':
            final args = settings.arguments as MessageDetailArgs;
            return PageRouteBuilder(
              pageBuilder: (_, _, _) => MessageDetailPage(messageId: args.id),
            );
          case '/emailDetail':
            final args = settings.arguments as EmailDetailArgs;
            return PageRouteBuilder(
              pageBuilder: (_, _, _) => EmailDetailPage(emailId: args.id),
            );
          case '/joinDetail':
            final args = settings.arguments as JoinDetailArgs;
            return PageRouteBuilder(
              pageBuilder: (_, _, _) => JoinDetailPage(joinId: args.id),
            );
          case '/taskDetail':
            final args = settings.arguments as TaskDetailArgs;
            return PageRouteBuilder(
              pageBuilder: (_, _, _) => TaskDetailPage(taskId: args.id),
            );
          case '/settingDetail':
            final args = settings.arguments as SettingDetailArgs;
            return PageRouteBuilder(
              pageBuilder: (_, _, _) => SettingDetailPage(settingId: args.id),
            );
        }
        return null;
      },
    );
  }
}
