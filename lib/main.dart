import 'package:flutter/material.dart';
import 'package:ifruit/models/email.dart';
import 'package:ifruit/models/message.dart';
import 'package:ifruit/pages/email/detail.dart';
import 'package:ifruit/pages/home/index.dart';
import 'package:ifruit/pages/message/detail.dart';
import 'package:ifruit/providers/global.dart';
import 'package:ifruit/routes/index.dart';
import 'package:ifruit/utils/audioplay.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AudioUtil().init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GlobalProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ifruit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(builders: {}),
      ),
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
        }
        return null;
      },
    );
  }
}
