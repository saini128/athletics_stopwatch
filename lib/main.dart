import 'package:athletics_stopwatch/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      showPerformanceOverlay: false,
      title: 'Stopwatch',
      home: Home(),
    );
  }
}
