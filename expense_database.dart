import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'expense.dart';

class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._init();
  static Database? _database;

  ExpenseDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE expenses (
  id $idType,
  title $textType,
  amount $doubleType,
  date $textType
)
''');
  }

  Future<Expense> create(Expense expense) async {
    final db = await instance.database;

    await db.insert('expenses', expense.toJson());
    return expense;
  }

  Future<List<Expense>> readAllExpenses() async {
    final db = await instance.database;

    final orderBy = 'date DESC';
    final result = await db.query('expenses', orderBy: orderBy);

    return result.map((json) => Expense.fromJson(json)).toList();
  }

  Future<void> delete(String id) async {
    final db = await instance.database;

    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
