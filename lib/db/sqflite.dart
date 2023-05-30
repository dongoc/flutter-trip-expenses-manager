import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trip_expenses_manager/models/expense.dart';
import 'package:trip_expenses_manager/models/trip.dart';

class TripDatabase {
  Future<Database> _openDb() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'trip.db');

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) => {},
    );

    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS trips (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE;
        
      CREATE TABLE IF NOT EXISTS expenses (
        id INTEGER PRIMARY KEY,
        trip_id INTEGER NOT NULL,
        description TEXT NOT NULL,
        amount INTEGER NOT NULL,
        date_time DATE NOT NULL,
        category TEXT,
      )
    ''');
  }

  Future<Trip> createTrip(trip) async {
    final db = await _openDb();
    trip.id = await db.insert(
      'trips',
      trip.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return trip;
  }

  Future<Trip> updateTrip(Trip trip) async {
    final db = await _openDb();
    await db.update(
      'trips',
      trip.toMap(),
      where: 'id = ?',
      whereArgs: [trip.id],
    );
    return trip;
  }

  Future<int> deleteTrip(int id) async {
    final db = await _openDb();
    await db.delete(
      'trips',
      where: 'id = ?',
      whereArgs: [id],
    );
    return id;
  }

  Future<Trip> getTrip(int id) async {
    final db = await _openDb();
    final List<Map<String, dynamic>> maps = await db.query(
      'trips',
      where: 'id = ?',
      whereArgs: [id],
    );

    return Trip.fromJson(maps[0]);
  }

  Future<List<Trip>> getTripList() async {
    final db = await _openDb();
    final List<Map<String, dynamic>> maps = await db.query('trips');

    return List.generate(maps.length, (i) {
      return Trip(
        id: maps[i]['id'],
        title: maps[i]['title'],
        startDate: maps[i]['start_date'],
        endDate: maps[i]['end_date'],
      );
    });
  }

  Future<Expense> getExpense(int id) async {
    final db = await _openDb();
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );

    return Expense.fromJson(maps[0]);
  }

  Future<List<Expense>> getExpenseList(int tripId) async {
    final db = await _openDb();
    final List<Map<String, dynamic>> maps =
        await db.query('expenses', where: 'trip_id = ?', whereArgs: [tripId]);

    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        tripId: maps[i]['trip_id'],
        description: maps[i]['description'],
        amount: maps[i]['amount'],
        dateTime: maps[i]['date_time'],
        category: maps[i]['category'],
      );
    });
  }

  Future<Expense> updateExpense(Expense expense) async {
    final db = await _openDb();
    await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
    return expense;
  }

  Future<int> deleteExpense(int id) async {
    final db = await _openDb();
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    return id;
  }
}
