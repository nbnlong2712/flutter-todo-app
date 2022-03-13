import 'package:flutter_todo/model/task.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDAO {
  Database? database;
  static const databaseName = "todo.db";

  Future open(String databaseName) async {
    database = await openDatabase(join(await getDatabasesPath(), databaseName), version: 1, onCreate: (db, version) {
      return db.execute(
          "create table Task(id TEXT primary key, taskName TEXT, taskContent TEXT, date TEXT, isDone INTEGER)");
    });
  }

  void insert(Task task) async {
    await open(databaseName);
    await database!.insert("Task", task.toMap());
  }

  void update(Task task) async {
    await open(databaseName);
    await database!.rawUpdate("update Task set taskName = ?, taskContent = ?, isDone = ? where id = ?",
        [task.taskName, task.taskContent, task.isDone ? 1 : 0, task.id]);
  }

  Future<List<Task>> getAllTaskFromDB() async {
    await open(databaseName);
    List<Map<String, dynamic>>? list = await database!.query("Task");
    return List.generate(
        list.length,
        (index) => Task(
              list[index]["id"],
              list[index]["taskName"],
              list[index]["taskContent"],
              DateFormat("yyyy-MM-dd hh:mm").parse(list[index]["date"]),
              list[index]["isDone"] == 1 ? true : false,
            ));
  }

  Future delete(String id) async {
    await open(databaseName);
    await database!.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  Future deleteAll() async {
    await open(databaseName);
    await database!.rawDelete("delete from Task");
  }

  Future close() async => database!.close();
}
