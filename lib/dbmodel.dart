import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Content {
  Content({this.id, this.content, this.date});

  final String content;
  final String date;
  final int id;

  Map<String, dynamic> tomap() {
    return {"content": this.content, "date": date};
  }
}

class DbHelper {
  Database db;

  DbHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "Notes.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,content TEXT,date TEXT)");
    }, version: 1);
  }

  Future<void> insertData(Content content) async {
    try {
      db.insert("notes", content.tomap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<List> getAllTasks() async {
    final List<Map<String, dynamic>> notes = await db.query("notes");
    return notes;
  }

  Future deleteData(id) async {
    try {
      return await db.delete("notes", where: " id= ? ", whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  Future updateData(Content updatedData) async {
    try {
      return await db.update("notes", updatedData.tomap(),
          where: "id= ?", whereArgs: [updatedData.id]);
    } catch (e) {
      print(e);
    }
  }
}
