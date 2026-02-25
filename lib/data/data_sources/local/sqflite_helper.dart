import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/product_model.dart';

class SqfliteHelper {
  static Database? _database;
  static const String tableName = 'products_cache';
  //cheak database if exist
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }
//if not exist create new
  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
//db open
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // create Table call once when created
  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id TEXT PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');
  }

  // cacheProducts sAVE PRODUCT LOCAL DB
  static Future<void> cacheProducts(List<ProductModel> products) async {
    final db = await database;
    Batch batch = db.batch();

    // DELLET previous table
    batch.delete(tableName);

    for (var product in products) {
      if (product.id != null) {
        batch.insert(
          tableName,
          {
            'id': product.id,
            // svae obj as json String
            'data': jsonEncode(product.toJson()),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    // save all data in batch
    await batch.commit(noResult: true);
  }

  //get products
  static Future<List<ProductModel>> getCachedProducts() async {
    final db = await database;
    //fetch all data from table
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    if (maps.isNotEmpty) {
      return maps.map((item) {
        final Map<String, dynamic> productMap = jsonDecode(item['data'] as String);
        return ProductModel.fromJson(productMap);
      }).toList();
    } else {
      return [];
    }
  }

  // delete cache logout
  static Future<void> clearCache() async {
    final db = await database;
    await db.delete(tableName);
  }
}