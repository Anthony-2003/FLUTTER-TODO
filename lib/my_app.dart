import 'package:flutter/material.dart';
import 'package:flutter_todo/views/task_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Anthony Notes App',
      home: TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}