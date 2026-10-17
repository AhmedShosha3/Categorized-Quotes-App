import 'package:final_project/pages/home_page.dart';
import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quotes App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: mode,
        home: const HomePage(),
      ),
    );
  }
}
