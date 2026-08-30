import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/router/index.dart';
import 'package:ifruit/core/setting/settings_provider.dart';
import 'package:ifruit/core/setting/settings_repository.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/features/home/page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DbHelper.instance.initFromJson();
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
        onGenerateRoute: generateRoutes,
      ),
      child: const HomePage(),
    );
  }
}
