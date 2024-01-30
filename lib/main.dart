import 'package:flutter/material.dart';
import 'chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chatbot',
      theme: ThemeData(brightness: Brightness.dark),
      home: ChatScreen(),
    );
  }
}