import 'package:flutter/material.dart';

import 'home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '木鱼',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}
