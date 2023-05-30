import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
        end_date DATE
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

  Future<Trip> updateTrip(trip) async {
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
}
