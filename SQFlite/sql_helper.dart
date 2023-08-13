import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';

class SQLHelper{

  static Future<void> createTable(sql.Database database) async{
    await database.execute("CREATE TABLE stud ( id INTEGER PRIMARY KEY"
        " AUTOINCREMENT NOT NULL, name TEXT, email TEXT, "
        "createdAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'sms.db',
      version: 1,
      onCreate: (sql.Database database, int version) async
        {
          await createTable(database);
        }
    );
  }

  static Future<int> AddStudent(String name, String? email) async
  {
    final db = await SQLHelper.db();
    final data = {'name' : name, 'email': email};
    final id = await db.insert('stud', data,
    conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getList() async
  {
    final db = await SQLHelper.db();
    return await db.query('stud', orderBy: "id");
  }

  static Future<List<Map<String,dynamic>>> getStudDetails(int id) async{
    final db = await SQLHelper.db();
    return await db.query('stud',where: " id = ?", whereArgs: [id]);
  }

  static Future<int> UpdateStudent(int id, String name, String? email) async{
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email,
      'createdAT':DateTime.now().toString()};
    final result = await db.update('stud', data,
    where: " id = ? ",
    whereArgs: [id]);
    return result;
  }

  static Future<void> DeleteStudent(int id) async{
    final db = await SQLHelper.db();
    await db.delete('stud', where: " id = ? ",whereArgs: [id]);
  }
}