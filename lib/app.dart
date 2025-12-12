import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/home_page.dart';

class KreweOfChristmasApp extends StatelessWidget {
  const KreweOfChristmasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krewe of Christmas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomePage(),  // ← Removed const here
    );
  }
}