import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study/practice.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}



class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  void addTask(String title, DateTime dueDate) {
    setState(() {
      tasks.add(Task(title: title, dueDate: dueDate));
    }
    );
  }

  void toggleTask(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
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
              onChanged: (value) => toggleTask(task),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteTask(task),
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
                          setState(() {
                              tasks.add(Task(title: newTaskTitle,dueDate: selectedDate!)); 
                              Navigator.of(context).pop();
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