import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            subtitle: Text(DateFormat('yyyy-MM-dd').format(task.dueDate)),
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
              DateTime? selectedDate;
              return StatefulBuilder(
                builder:(BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('New Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                      newTaskTitle = value;
                      },
                      decoration : InputDecoration(labelText: 'Task Title',),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(), 
                        lastDate: DateTime(2100)
                      );
                      setState(() {
                        selectedDate = picked;
                      });
                    },
                    child: Text(  selectedDate != null
                    ?'Due Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
                    : 'Select Due Date',
                    ),
                    ),
                    
                
              ],
                
              ),
                  actions: <Widget>[
                  TextButton( child: Text('Cancel'), onPressed: () { Navigator.of(context).pop(); }, ), 
                  ElevatedButton( child: Text('Add'), onPressed: () {
                     if (newTaskTitle != null && newTaskTitle.isNotEmpty) {
                        setState(() {
                          tasks.add(Task(title: newTaskTitle, dueDate: selectedDate!)); 
                        });
                        Navigator.of(context).pop();
                       } 
                      },
                    ),
                   ],
                  );
                },
              );
            },
                
              );
           },
          child: Icon(Icons.add), 
        ), 
      ); 
    } 
  }
