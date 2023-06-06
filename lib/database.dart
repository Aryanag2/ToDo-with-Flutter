import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:study/practice.dart';

class DatabaseHelper{
    static Database? _database;
    static const String dbName = 'todo.db';
    Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async{

    
    String path = await getDatabasesPath();
print(path);
    return openDatabase(
      join(path, 'toDo_db.db'),
      onCreate: (database, version) async => await db.execute("
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isCompleted INTEGER,
            dueDate TEXT
          )",
        ),
    );
    
  
  }
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> taskMaps = await db.query('tasks');
    return List.generate(taskMaps.length, (index) {
      return Task(
        id: taskMaps[index]['id'],
        title: taskMaps[index]['title'],
        isCompleted: taskMaps[index]['isCompleted'] == 1 ? true : false,
        dueDate: DateTime.parse(taskMaps[index]['dueDate']),
      );
    });
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int taskId) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}