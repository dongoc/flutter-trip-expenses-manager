import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trip_expenses_manager/models/expense.dart';
import 'package:trip_expenses_manager/models/trip.dart';
import 'package:trip_expenses_manager/models/trip_form.dart';

import '../models/expense_form.dart';
import '../utils/formatter.dart';

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
      CREATE TABLE IF NOT EXISTS trips(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE)
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS expenses (
        id INTEGER PRIMARY KEY,
        trip_id INTEGER NOT NULL,
        description TEXT NOT NULL,
        amount INTEGER NOT NULL,
        date_time DATE NOT NULL,
        category TEXT)
    ''');
  }

  Future<Trip> createTrip(TripForm tripForm) async {
    final db = await _openDb();
    int id = await db.insert(
      'trips',
      tripForm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    Trip trip = Trip(
      id: id,
      title: tripForm.title,
      startDate: tripForm.startDate,
      endDate: tripForm.endDate,
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

    List<Trip> tripList = List.generate(maps.length, (i) {
      return Trip(
        id: maps[i]['id'],
        title: maps[i]['title'],
        startDate: DateTime.parse(maps[i]['start_date']),
        endDate: maps[i]['end_date'] != null
            ? DateTime.parse(maps[i]['end_date'])
            : null,
      );
    });

    tripList.sort((a, b) => (b.startDate.compareTo(a.startDate)));

    return tripList;
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
        dateTime: DateTime.parse(maps[i]['date_time']),
        category: stringToExpenseCategoryKey(maps[i]['category']),
      );
    });
  }

  Future<Expense> createExpense(ExpenseForm expenseForm) async {
    final db = await _openDb();
    int id = await db.insert(
      'expenses',
      expenseForm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    Expense expense = Expense(
        id: id,
        tripId: expenseForm.tripId,
        amount: expenseForm.amount,
        dateTime: expenseForm.dateTime,
        description: expenseForm.description,
        category: expenseForm.category);
    return expense;
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
