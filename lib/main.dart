import 'package:flutter/material.dart';
import 'package:video_calling_task/user_page.dart';
import 'package:video_calling_task/zim_video_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zego Video Calling',
      home: HomeScreen(),
    );
  }
}
