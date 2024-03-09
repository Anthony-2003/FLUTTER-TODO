import 'dart:async';
import 'package:flutter_todo/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static late Database _database;
  static const String tableTask = 'tasks';

  static Future<Database> get database async {
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Crear la tabla de tareas si no existe
        await db.execute('''
          CREATE TABLE $tableTask (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            completed BOOLEAN
          )
        ''');
      },
    );
  }

  static Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(tableTask, task.toMap());
  }

  static Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(tableTask, task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(tableTask, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableTask);

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        completed: maps[i]['completed'] == 1,
      );
    });
    
  }
}
