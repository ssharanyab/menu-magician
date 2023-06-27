import 'package:menu_magician/models/menu_item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbVersion = 1;
  static const _dbName = "MenuItems.db";

  static Future<Database> _getDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
          "CREATE TABLE MenuItems(id INTEGER PRIMARY KEY, meal TEXT NOT NULL, itemName TEXT NOT NULL, itemDescription TEXT)"),
      version: _dbVersion,
    );
  }

  /// Insert a new [MenuItem] into the database.
  static Future<int> insertMenuItem(MenuItem menuItem) async {
    final db = await _getDB();
    return await db.insert(
      'MenuItems',
      menuItem.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Update a [MenuItem] in the database.
  static Future<int> updateMenuItem(MenuItem menuItem) async {
    final db = await _getDB();
    return await db.update(
      'MenuItems',
      menuItem.toJson(),
      where: 'id = ?',
      whereArgs: [menuItem.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete a [MenuItem] from the database.
  static Future<int> deleteMenuItem(MenuItem menuItem) async {
    final db = await _getDB();
    return await db.delete(
      'MenuItems',
      where: 'id = ?',
      whereArgs: [menuItem.id],
    );
  }

  /// Get all [MenuItem]s from the database.
  static Future<List<MenuItem>?> getMenuItems() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('MenuItems');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (i) {
      return MenuItem.fromJson(maps[i]);
    });
  }
}
