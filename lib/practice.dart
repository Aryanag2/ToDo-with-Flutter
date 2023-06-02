import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study/ToDo.dart';

void main() => runApp(MyApp());

class Task {
  String title;
  bool isCompleted;
  DateTime dueDate;
  Task({required this.title, this.isCompleted = false, required this.dueDate});
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}
