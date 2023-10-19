import 'dart:async';

import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tvseries_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblTVWatchlist = 'tvwatchlist';
  static const String _tblCache = 'cache';
  static const String _tblCacheTv = 'cachetv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute(''' 
      CREATE TABLE $_tblTVWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      )
    ''');

    await db.execute(''' 
    CREATE TABLE $_tblCache (
      id INTEGER PRIMARY KEY,
      title TEXT,
      overview TEXT,
      posterPath TEXT,
      category TEXT
    );
    ''');

    await db.execute(''' 
    CREATE TABLE $_tblCacheTv (
      id INTEGER PRIMARY KEY,
      name TEXT,
      overview TEXT,
      posterPath TEXT,
      category TEXT
    );
    ''');
  }

  Future<void> insertCacheTvTransaction(
      List<TvTable> tvseries, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (var tv in tvseries) {
        final tvJson = tv.toJson();
        tvJson['category'] = category;
        txn.insert(_tblCacheTv, tvJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTv(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(
      _tblCacheTv,
      where: 'category = ?',
      whereArgs: [category],
    );
    return result;
  }

  Future<void> insertCacheTransaction(
      List<MovieTable> movies, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (var movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCache, movieJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
    return result;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> clearCacheTv(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheTv,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<int> insertTVWatchlist(TvTable tvTable) async {
    final db = await database;
    return await db!.insert(_tblTVWatchlist, tvTable.toJson());
  }

  Future<int> removeTVWatchlist(TvTable tvTable) async {
    final db = await database;
    return await db!.delete(
      _tblTVWatchlist,
      where: 'id = ?',
      whereArgs: [tvTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTVWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchListTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTVWatchlist);

    return results;
  }
}
