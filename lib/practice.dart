import 'package:flutter/material.dart';
import 'package:study/ToDo.dart';


void main() async{
  runApp(MyApp());  
  }

class Task {
  int id;
  String title;
  bool isCompleted;
  DateTime dueDate;
  Task({required this.id, required this.title, this.isCompleted = false, required this.dueDate});

  Map <String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'isCompleted?' : isCompleted,
      'dueDate' : dueDate.toIso8601String(),
    };
  }
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


// shared refernce