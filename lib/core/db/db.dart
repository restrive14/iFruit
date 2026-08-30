import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._internal();
  DbHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, "app_db.db");

    return await openDatabase(
      dbPath,
      version: 3,
      onCreate: (db, version) async {
        await _ensureTableExists(db, 'email', '''
          CREATE TABLE IF NOT EXISTS email (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            avatar VARCHAR(50),
            title VARCHAR(50),
            description VARCHAR(50),
            content VARCHAR(500),
            time DATETIME DEFAULT CURRENT_TIME,
            is_read INTEGER NOT NULL DEFAULT 0
          )
        ''');

        await _ensureTableExists(db, 'message', '''
          CREATE TABLE IF NOT EXISTS message (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            avatar VARCHAR(50),
            title VARCHAR(50),
            content VARCHAR(500),
            time DATETIME DEFAULT CURRENT_TIME,
            is_read INTEGER NOT NULL DEFAULT 0
          )
        ''');

        await _ensureTableExists(db, 'task', '''
          CREATE TABLE IF NOT EXISTS task (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            avatar VARCHAR(50),
            name VARCHAR(50),
            title VARCHAR(50),
            content VARCHAR(500),
            is_read INTEGER NOT NULL DEFAULT 0
          )
        ''');

        await _ensureTableExists(db, 'friend', '''
          CREATE TABLE IF NOT EXISTS friend (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            avatar VARCHAR(50),
            name VARCHAR(50)
          )
        ''');

        await _ensureTableExists(db, 'club', '''
          CREATE TABLE IF NOT EXISTS club (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            avatar VARCHAR(50),
            name VARCHAR(50),
            content VARCHAR(500),
            is_read INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _ensureTableExists(db, 'friend', '''
            CREATE TABLE IF NOT EXISTS friend (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              avatar VARCHAR(50),
              name VARCHAR(50)
            )
          ''');
        }

        if (oldVersion < 3) {
          for (final tableName in ['email', 'message', 'task', 'club']) {
            await _ensureColumnExists(
              db,
              tableName,
              'is_read',
              'INTEGER NOT NULL DEFAULT 0',
            );
          }
        }
      },
    );
  }

  Future<void> _ensureTableExists(
    Database db,
    String tableName,
    String sql,
  ) async {
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );

    if (tables.isEmpty) {
      await db.execute(sql);
    }
  }

  Future<void> _ensureColumnExists(
    Database db,
    String tableName,
    String columnName,
    String columnDef,
  ) async {
    final columns = await db.rawQuery('PRAGMA table_info($tableName)');
    final exists = columns.any((column) => column['name'] == columnName);

    if (!exists) {
      await db.execute(
        'ALTER TABLE $tableName ADD COLUMN $columnName $columnDef',
      );
    }
  }

  Future<void> initFromJson({bool force = false}) async {
    final db = await instance.db;

    final tableMap = {
      'email': 'assets/data/email.json',
      'message': 'assets/data/message.json',
      'task': 'assets/data/task.json',
      'friend': 'assets/data/friend.json',
      'club': 'assets/data/club.json',
    };

    for (final entry in tableMap.entries) {
      final tableName = entry.key;
      final assetPath = entry.value;

      try {
        if (force) {
          await db.delete(tableName);
        } else {
          final count = Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $tableName'),
          );

          if (count != null && count > 0) {
            continue;
          }
        }

        final jsonString = await rootBundle.loadString(assetPath);
        final list = jsonDecode(jsonString) as List;

        for (final item in list) {
          final map = item as Map<String, dynamic>;

          final data = <String, dynamic>{};
          if (tableName == 'email') {
            data['avatar'] = map['avatar'] ?? '';
            data['title'] = map['title'] ?? '';
            data['description'] = map['description'] ?? '';
            data['content'] = map['content'] ?? '';
            data['time'] = map['time'] ?? _currentTimeString();
            data['is_read'] = 0;
          } else if (tableName == 'message') {
            data['avatar'] = map['avatar'] ?? '';
            data['title'] = map['title'] ?? '';
            data['content'] = map['content'] ?? '';
            data['time'] = map['time'] ?? _currentTimeString();
            data['is_read'] = 0;
          } else if (tableName == 'task') {
            data['avatar'] = map['avatar'] ?? '';
            data['name'] = map['name'] ?? '';
            data['title'] = map['title'] ?? '';
            data['content'] = map['content'] ?? '';
            data['is_read'] = 0;
          } else if (tableName == 'friend') {
            data['avatar'] = map['avatar'] ?? '';
            data['name'] = map['name'] ?? '';
          } else if (tableName == 'club') {
            data['avatar'] = map['avatar'] ?? '';
            data['name'] = map['name'] ?? '';
            data['content'] = map['content'] ?? '';
            data['is_read'] = 0;
          }

          if (data.isNotEmpty) {
            await db.insert(
              tableName,
              data,
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
      } catch (_) {
        // Ignore missing asset files or already-initialized tables.
      }
    }
  }

  Future<void> resetAllFromJson() async {
    await initFromJson(force: true);
  }

  String _currentTimeString() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  // ------------------- CRUD 封装 -------------------
  // 插入
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await instance.db;
    return await db.insert(table, data);
  }

  // 查询全部
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await instance.db;
    return await db.query(table);
  }

  // 根据条件查询
  Future<List<Map<String, dynamic>>> queryWhere(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await instance.db;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> markRead(String table, String id) async {
    final db = await instance.db;
    return await db.update(
      table,
      {'is_read': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> countUnread(String table) async {
    final db = await instance.db;
    final res = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM $table WHERE is_read = 0',
    );
    return Sqflite.firstIntValue(res) ?? 0;
  }

  // 更新
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await instance.db;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  // 删除
  Future<int> delete(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await instance.db;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  // 关闭数据库
  Future close() async {
    final db = await instance.db;
    db.close();
  }
}
