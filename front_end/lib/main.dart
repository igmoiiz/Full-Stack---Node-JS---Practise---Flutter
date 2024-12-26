import 'package:flutter/material.dart';
import 'package:front_end/View/get_page.dart';
import 'package:front_end/View/post_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const PostPage(),
        '/get_page': (context) => const GetPage(),
      },
    );
  }
}
