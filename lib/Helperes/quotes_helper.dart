import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper dbHalper = DBHelper();
  Database? database;

  Future<Database?> checkDb() async {
    if (database != null) {
      return database;
    } else {
      return await createDb();
    }
  }

  Future<Database> createDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'jeet.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT,love TEXT,svn TEXT,aeq TEXT,mq Text)";
        db.execute(query);
      },
    );
  }

  Future<void> insertData(
      {required String love,
        required String svn,
        required String aeq,
        required String mq}) async {
    database = await checkDb();
    database!.insert(
      "quotes",
      {
        "love": love,
        "svn": svn,
        "aeq": aeq,
        "mq": mq,
      },
    );
  }

  Future<List<Map>> readData() async {
    database = await checkDb();
    String query = "SELECT * FROM quotes";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  Future<void> deleteData({required int id}) async {
    database = await checkDb();
    database!.delete(
      "quotes",
      where: "id = ?",
      whereArgs: [id],
    );
  }

// Future<void> updateData(
//     {required int id, required String love, required String number}) async {
//   database = await checkDb();
//   database!.update(
//     "todo",
//     {"task": name, "category": number},
//     where: "id = ?",
//     whereArgs: [id],
//   );
// }
}
