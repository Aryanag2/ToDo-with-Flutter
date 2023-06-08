import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:study/ToDo.dart';
=======
import 'package:intl/intl.dart';
import 'ToDoListScreen.dart';
>>>>>>> parent of 108952a (added new file)


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

<<<<<<< HEAD

// shared refernce
=======
>>>>>>> parent of 108952a (added new file)
