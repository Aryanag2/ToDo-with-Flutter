import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study/practice.dart';
import 'package:study/database.dart';


class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}



class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];
  final dbHelper = DatabaseHelper();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final loadedTasks = await dbHelper.getTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }
  Future<void> addTask( String title, DateTime dueDate) async {
    final task = Task(
    id: tasks.length + 1,
    title: title,
    dueDate: dueDate,
    );
    await dbHelper.insertTask(task);
    await loadTasks();
    setState(() {
      tasks.add(task);
    });

  }

  Future<void> toggleTask(Task task) async{
    task.isCompleted = !task.isCompleted;
    await dbHelper.updateTask(task);
    await loadTasks();
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void deleteTask(Task task) async{
    setState(() {
      tasks.remove(task);
    });
    await dbHelper.deleteTask(task.id);
    await loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(DateFormat('yMd').format(task.dueDate)),
            // subtitle: Text("abc"),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) { 
                
                 toggleTask(task);
                
                },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){  
                  deleteTask(task);
              },
            ),
          );
        },
      ),
floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTaskTitle='';
              DateTime? selectedDate ;
              return AlertDialog(
                title: Text('New Task'),
                content: TextField(
                  onChanged: (value) {
                    newTaskTitle = value;
                  },
                  ),
                 
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Select Date'),
                      onPressed: () async
                      {
                           DateTime? selectedDate = await showDatePicker(
                           context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101)
                         );
                          if (newTaskTitle != null && newTaskTitle.isNotEmpty){
                            // await addTask( newTaskTitle, selectedDate!);

                            setState(() {
                              // tasks.add(Task(id: tasks.length +1, title: newTaskTitle,dueDate: selectedDate!)); 
                             try{
                              addTask( newTaskTitle, selectedDate!);
                             
                              Navigator.of(context).pop();
                             }
                             catch (e){
                               print(e);
                             }
                            });
                             
                      }
                      }
                      
                   ), 
                  
                  ], 
                );
                
              }, 
            ); 
           }, 
          child: Icon(Icons.add), 
        ), 
      ); 
    } 
  }
