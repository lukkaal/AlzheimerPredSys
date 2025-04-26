import 'package:ad_application/auth/view/pages/signup_page.dart';
import 'package:ad_application/pages/drawing_page.dart';
import 'package:ad_application/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/view/theme/theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: DrawingPage(),
    );
  }
}

