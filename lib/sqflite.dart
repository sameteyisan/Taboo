import 'package:Taboo/sonuc_ekrani.dart';
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
  final int takim2;
  final int takim1;
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
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT,$Column_takim2 INTEGER, $Column_takim1 INTEGER)");
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

  Future calculateTotal() async {
    var result = sirakontrol % 2 == 0
        ? await db
            .rawQuery("SELECT SUM($Column_takim1) as Total FROM $tableName")
        : await db
            .rawQuery("SELECT SUM($Column_takim2) as Total FROM $tableName");
    var xx = result.toList();
    xx.forEach((element) {
      sirakontrol % 2 == 0
          ? takim1Skor = element['Total']
          : takim2Skor = element['Total'];
    });
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
