import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static final DatabaseHandler _instance = DatabaseHandler._internal();
  factory DatabaseHandler() => _instance;
  static Database? _database;

  DatabaseHandler._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_macros.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    // Crear tabla Alimento
    await db.execute('''
      CREATE TABLE aliment(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        supermarket TEXT NOT NULL,
        image_base64 TEXT,
        calories REAL NOT NULL,
        fats REAL NOT NULL,
        fats_saturated REAL,
        fats_polyunsaturated REAL,
        fats_monounsaturated REAL,
        fats_trans REAL,
        carbohydrates REAL NOT NULL,
        fiber REAL,
        sugar REAL,
        proteins REAL NOT NULL,
        salt REAL
      );
    ''');

    // Crear tabla Receta
    await db.execute('''
      CREATE TABLE recipe(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    // Crear tabla Receta_Alimento (tabla intermedia)
    await db.execute('''
      CREATE TABLE recipe_aliment(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_recipe INTEGER,
        id_aliment INTEGER,
        quantity REAL NOT NULL,
        FOREIGN KEY (id_recipe) REFERENCES recipe(id) ON DELETE CASCADE,
        FOREIGN KEY (id_aliment) REFERENCES aliment(id) ON DELETE CASCADE
      );
    ''');

    // Crear tabla Gasto
    await db.execute('''
      CREATE TABLE spent(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_aliment INTEGER,
        date DATE NOT NULL,
        quantity REAL NOT NULL,
        FOREIGN KEY (id_aliment) REFERENCES aliment(id) ON DELETE CASCADE
      );
    ''');
  }

  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}
