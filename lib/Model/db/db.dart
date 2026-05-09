import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_agenda/Model/contact.dart';

class ContactsDBHelper {
  //  -- Singleton -- we create a internal constructor and made one instance of the database
  ContactsDBHelper._internal();
  static final ContactsDBHelper instance = ContactsDBHelper._internal();

  //  --- Config ---

  static Database? _database;
  static const _dbName = 'contacts.db';
  static const _dbVersion = 1;
  static const _tableName = 'contacts';

  Database? _db;
  final _initLock =
      Completer<
        void
      >(); // This allow us to have a controll of one specific activity

  Future<Database> get database async {
    if (_database != null) return _database!;

    if (!_initLock.isCompleted) {
      unawaited(_initDB());
      await _initLock.future;
      return _database!;
    } else {
      await _initDB();
      return _database!;
    }
  }

  Future<void> _initDB() async {
    try {
      String path = join(await getDatabasesPath(), _dbName);
      _database = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: (db, version) async {
          await _createSchema(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {},
      );
    } finally {
      if (!_initLock.isCompleted) _initLock.complete();
    }
  }

  Future<void> _createSchema(Database db) async {
    await db.execute(''' 
    CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT ,
            name      TEXT       NOT NULL,
            lastName  TEXT       NOT NULL,
            tel       INTEGER    NOT NULL,
            cant      INTEGER    NOT NULL  DEFAULT 0 CHECK(cant >= 0)
          )
    ''');

    //Busquedas mas rapidas por nombre
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_contactos_nombre ON $_tableName(name);',
    );
  }

  // _____CRUD________   28:16

  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert(
      _tableName,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm
          .abort, // esto es por si repetimos el mismo producto al insertar
    );
  }

  
  Future<List<Contact>> getContacts({
    String? search,
    String orderBy = 'name ASC',
  }) async {
    final db = await database;

    final where = (search == null || search.trim().isEmpty)
        ? null
        : "name LIKE ?";

    final whereArgs = (where == null) ? null : ["%${search!.trim()}%"];

    final rows = await db.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );

    return rows.map(
      (m) {
        return Contact(
          id: m['id'] as int,
          name: m['name'] as String,
          lastName: m['lastName'] as String,
          tel: m['tel'] as int,
          cant: ValueNotifier<int>(m['cant'] as int),
        );
      },
    ).toList(growable: false);

   
  }

  Future<int> updateContact(Contact contact) async {
    final db = await database;
    return await db.update(
      _tableName,
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
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
      lastName: m["lastName"] as String,
      tel: m["tel"] as int,
      cant: ValueNotifier<int>(m["cant"] as int),
    );
  }
}
