import 'package:flutter/material.dart';

import 'presentation/tasks/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow.shade800),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
