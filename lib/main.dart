import 'package:flutter/material.dart';
import 'package:polmeme/auth/login_page.dart';
import 'package:polmeme/home/home.dart';
import 'package:provider/provider.dart';

import 'core/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Polmeme',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE0E0E12),
      ),
      home: LoginPage(),
    );
  }
}
