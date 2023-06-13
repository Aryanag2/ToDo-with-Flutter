import 'package:flutter/material.dart';
import 'ToDo.dart';

// void main() => runApp(MyApp());

class Task {
  int id;
  String title;
  bool isCompleted;
  DateTime dueDate;
  Task(
      {required this.id,
      required this.title,
      this.isCompleted = false,
      required this.dueDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted?': isCompleted,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}

class MyApp2 extends StatelessWidget {
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
