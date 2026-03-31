import 'package:flutter/material.dart';

import 'leave.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '请假',
      theme: ThemeData(
        fontFamily: 'PingFang',
      ),
      home: LeaveListPage(),
    );
  }
}
