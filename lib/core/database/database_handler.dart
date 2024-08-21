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
      CREATE TABLE alimento(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        imagen_base64 TEXT,
        calorias REAL NOT NULL,
        grasas REAL NOT NULL,
        carbohidratos REAL NOT NULL,
        proteinas REAL NOT NULL
      );
    ''');

    // Crear tabla Receta
    await db.execute('''
      CREATE TABLE receta(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL
      );
    ''');

    // Crear tabla Receta_Alimento (tabla intermedia)
    await db.execute('''
      CREATE TABLE receta_alimento(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_receta INTEGER,
        id_alimento INTEGER,
        cantidad REAL NOT NULL,
        FOREIGN KEY (id_receta) REFERENCES Receta(id) ON DELETE CASCADE,
        FOREIGN KEY (id_alimento) REFERENCES Alimento(id) ON DELETE CASCADE
      );
    ''');

    // Crear tabla Gasto
    await db.execute('''
      CREATE TABLE gasto(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_alimento INTEGER,
        fecha DATE NOT NULL,
        cantidad REAL NOT NULL,
        FOREIGN KEY (id_alimento) REFERENCES Alimento(id) ON DELETE CASCADE
      );
    ''');
  }

  Future<void> closeDatabase() async {
    final db = await database;
    db.close();
  }
}
