import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_agenda/Model/contact.dart';

class ContactsDBHelper {
  //  -- Singleton -- we create a internal constructor and made one instance of the database
  ContactsDBHelper.internal();
  static final ContactsDBHelper instance = ContactsDBHelper.internal();

  //  --- Config ---

  static Database? _database;
  static const _dbName = 'contacts.db';
  static const _dbVersion = 2;
  static const _tableName = 'contacts';

  Database? _db;
  final _initLock =
      Completer<
        void
      >(); // This allow us to have a controll of one specific activity

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), _dbName);

    print("pathDB: " + path);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            idContact INTEGER PRIMARY KEY AUTOINCREMENT,
            id INTEGER ,
            name TEXT,
            Lastname TEXT,
            tel INTEGER,
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int version) async {
        // Código para realizar las modificaciones en la base de datos
      },
    );
  }

  // _____CRUD________

  static Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert(
      _tableName,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

/* getContact({String? search , String orderBy = "nombre ASC"}){
  final db = await database;
  final where = (search == null || search.trim().isEmpty) ? null : "nombre LIKE ?";
  final whereArgs = (where == null) ? null : ["%${search!.trim()}%"];
  final rows = await db.query(_tableName, where:where,whereArgs: whereArgs,orderBy: orderBy);
*/
  static Future<List<Contact>> getContacts() async {
    final db = await database; 

    List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['idContact'],
        name: maps[i]['Name'],
        Lastname: maps[i]['Last Name'],
        cant: ValueNotifier<int>(maps[i]['cantidad']),
        tel: maps[i]["Telefone"],
      );
    });
  }

  static Future<int> updateContact(Contact contact) async {
    final db = await database;
    return await db.update(
      _tableName,
      contact.toMap(),
      where: 'idContact = ?',
      whereArgs: [contact.id],
    );
  }
  



  static Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'idContact = ?', whereArgs: [id]);
  }

  Future<Contact?> getContactById(int id) async {
    final db = await database;
    final rows = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final m = rows.first;
    return Contact(
      id: m["id"] as int,
      name: m["name"] as String,
      Lastname: m["Lastname"] as String,
      tel: m["tel"] as int,
      cant: ValueNotifier<int>(m["cant"] as int),
    );
  }
}
