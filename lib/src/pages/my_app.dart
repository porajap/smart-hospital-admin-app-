import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:smart_hospital_admin/src/pages/login/login_page.dart';

import '../services/navigation_service.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';
import 'dashboard/dashboard_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final logger = Logger(
  printer: PrettyPrinter(),
);

final loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      Logger.level = Level.nothing;
    } else {
      Logger.level = Level.debug;
    }

    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: '${Constants.appName}',
      theme: AppTheme.primaryTheme,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
