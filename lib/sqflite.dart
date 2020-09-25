import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//if not exists
final String tableName = "OyunBilgileri";
// ignore: non_constant_identifier_names
final String Column_id = "ID";
// ignore: non_constant_identifier_names
final String Column_takim1 = "Takım1";
// ignore: non_constant_identifier_names
final String Column_takim2 = "Takım2";

class TaskModel {
  final String takim2;
  final String takim1;
  int id;

  TaskModel({
    this.takim1,
    this.id,
    this.takim2,
  });

  Map<String, dynamic> toMap() {
    return {
      Column_takim2: this.takim2,
      Column_takim1: this.takim1,
    };
  }
}

class TodoHelper {
  Database db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT,$Column_takim2 TEXT, $Column_takim1 TEXT)");
    }, version: 1);
  }

  Future<void> insertTask(TaskModel task) async {
    try {
      db.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<List<TaskModel>> getAllTask() async {
    final List<Map<String, dynamic>> tasks = await db.query(tableName);

    return List.generate(tasks.length, (i) {
      return TaskModel(
        takim2: tasks[i][Column_takim2],
        takim1: tasks[i][Column_takim1],
      );
    });
  }
}
