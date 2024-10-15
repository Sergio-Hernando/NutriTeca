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
      CREATE TABLE additives(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        additive_number TEXT NOT NULL,
        description TEXT NOT NULL
      );
    ''');

    await db.execute('''
    INSERT INTO additives (id, additive_number, name, description) VALUES 
    (1, 'E951', 'Aspartame', 'Edulcorante artificial en bebidas y productos bajos en calorías. Puede causar dolores de cabeza.'),
    (2, 'E621', 'Glutamato monosódico ', 'Potenciador del sabor en alimentos procesados. Puede provocar reacciones adversas en algunas personas.'),
    (3, 'E102', 'Colorante tartrazina', 'Colorante en golosinas y bebidas. Asociado con hiperactividad y reacciones alérgicas.'),
    (4, 'E129', 'Colorante Rojo Allura', 'Colorante en productos de repostería. Puede causar reacciones alérgicas en algunos individuos.'),
    (5, 'E320', 'BHA', 'Conservante en alimentos fritos. Potencialmente cancerígeno en altas dosis.'),
    (6, 'E321', 'BHT', 'Conservante en cereales. Potencialmente cancerígeno en altas dosis.'),
    (7, 'E202', 'Sorbato de potasio', 'Conservante en productos horneados. Puede causar reacciones alérgicas.'),
    (8, 'E211', 'Benzoato de sodio', 'Conservante en refrescos. Posible formación de benceno en condiciones de luz y calor.'),
    (9, 'E407', 'Carragenano', 'Espesante en productos lácteos. Asociado con problemas digestivos.'),
    (10, 'E338', 'Fosfatos', 'Agentes leudantes en productos horneados. Pueden afectar la salud ósea.'),
    (11, 'E514', 'Sulfato de sodio', 'Conservante en productos deshidratados. Puede causar reacciones alérgicas.'),
    (12, 'E420', 'Sorbitol', 'Edulcorante en productos dietéticos. Puede causar efectos laxantes en grandes cantidades.'),
    (13, 'E210', 'Ácido benzoico', 'Conservante en salsas. Puede causar reacciones alérgicas.'),
    (14, 'E1520', 'Propilenglicol', 'Humectante en productos horneados. Puede causar irritación en algunas personas.'),
    (15, 'E220', 'Dióxido de azufre', 'Conservante en frutas secas y vinos. Puede causar reacciones alérgicas.'),
    (16, 'E330', 'Ácido cítrico', 'Conservante y potenciador de sabor. Generalmente seguro, pero puede irritar a personas sensibles.'),
    (17, 'E400', 'Gluten', 'Agente espesante en productos horneados. Puede causar problemas en personas con enfermedad celíaca.'),
    (18, 'E471', 'Emulgente', 'Mejora la textura en productos horneados. Puede ser de origen animal.'),
    (19, 'E621', 'Ácido glutámico', 'Potenciador del sabor en alimentos procesados. Puede causar reacciones en algunas personas.'),
    (20, 'E471', 'Estearato de glicerol', 'Emulsificante en productos lácteos. Puede causar reacciones alérgicas.'),
    (21, 'E415', 'Goma xantana', 'Espesante en salsas. Generalmente seguro, pero puede causar problemas digestivos.'),
    (22, 'E412', 'Goma guar', 'Espesante en productos procesados. Puede causar problemas digestivos en dosis altas.'),
    (23, 'E1422', 'Almidón modificado', 'Espesante en alimentos procesados. Puede causar reacciones alérgicas.'),
    (24, 'E954', 'Sacarina', 'Edulcorante artificial en productos bajos en calorías. Debatida su seguridad y relación con el cáncer.'),
    (25, 'E422', 'Glicerol', 'Humectante en productos horneados. Generalmente seguro, pero puede causar irritación.');
  ''');

    await db.execute('''
      CREATE TABLE aliment(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        supermarket TEXT NOT NULL,
        image_base64 TEXT,
        calories INTEGER NOT NULL,
        fats INTEGER NOT NULL,
        fats_saturated INTEGER,
        fats_polyunsaturated INTEGER,
        fats_monounsaturated INTEGER,
        fats_trans INTEGER,
        carbohydrates INTEGER NOT NULL,
        fiber INTEGER,
        sugar INTEGER,
        proteins INTEGER NOT NULL,
        salt INTEGER
      );
    ''');

    // Crear tabla Receta
    await db.execute('''
      CREATE TABLE recipe(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        instructions TEXT NOT NULL
      );
    ''');

    // Crear tabla Receta_Alimento (tabla intermedia)
    await db.execute('''
      CREATE TABLE recipe_aliment(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_recipe INTEGER,
        id_aliment INTEGER,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (id_recipe) REFERENCES recipe(id) ON DELETE CASCADE,
        FOREIGN KEY (id_aliment) REFERENCES aliment(id) ON DELETE CASCADE
      );
    ''');

    // Crear tabla Gasto
    await db.execute('''
      CREATE TABLE spent(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_aliment INTEGER,
        aliment_name TEXT NOT NULL,
        date TEXT NOT NULL,
        quantity INTEGER NOT NULL,
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
