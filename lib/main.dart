import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifruit/core/router/index.dart';
import 'package:ifruit/core/setting/settings_provider.dart';
import 'package:ifruit/core/setting/settings_repository.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/features/club/detail.dart';
import 'package:ifruit/features/club/model.dart';
import 'package:ifruit/features/email/detail.dart';
import 'package:ifruit/features/email/model.dart';
import 'package:ifruit/features/friend/calling.dart';
import 'package:ifruit/features/friend/model.dart';
import 'package:ifruit/features/home/index.dart';
import 'package:ifruit/features/join/detail.dart';
import 'package:ifruit/features/join/model.dart';
import 'package:ifruit/features/join/second.dart';
import 'package:ifruit/features/message/detail.dart';
import 'package:ifruit/features/message/model.dart';
import 'package:ifruit/features/setting/detail.dart';
import 'package:ifruit/features/setting/model.dart';
import 'package:ifruit/features/task/detail.dart';
import 'package:ifruit/features/task/model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AudioUtil().init();

  final prefs = await SharedPreferences.getInstance();
  final repository = SettingsRepository(prefs);
  final settingsProvider = SettingsProvider(repository);
  await settingsProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>.value(value: settingsProvider),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ifruit',
        theme: settings.themeData,
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
            case '/secondDetail':
              final args = settings.arguments as JoinDetailArgs;
              return PageRouteBuilder(
                pageBuilder: (_, _, _) => SecondDetailPage(joinId: args.id),
              );
            case '/taskDetail':
              final args = settings.arguments as TaskDetailArgs;
              return PageRouteBuilder(
                pageBuilder: (_, _, _) => TaskDetailPage(taskId: args.id),
              );
            case '/settingDetail':
              final args = settings.arguments as SettingDetailArgs;
              return PageRouteBuilder(
                pageBuilder: (_, _, _) =>
                    SettingDetailPage(id: args.id, title: args.title),
              );
            case '/clubDetail':
              final args = settings.arguments as ClubDetailArgs;
              return PageRouteBuilder(
                pageBuilder: (_, _, _) => ClubDetailPage(clubId: args.id),
              );
            case '/calling':
              final args = settings.arguments as CallingArgs;
              return PageRouteBuilder(
                pageBuilder: (_, _, _) => CallingPage(id: args.id),
              );
          }
          return null;
        },
      ),
      child: const HomePage(),
    );
  }
}
