import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late DatabaseHelper databaseHelper;
  late MockDatabase mockDatabase;

  setUp(() async {
    sqfliteFfiInit();
    mockDatabase = MockDatabase();
    databaseHelper = DatabaseHelper();
    databaseFactory = databaseFactoryFfi;
  });

  final movieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );
  final tvTable = TvTable(
    id: 1,
    name: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  group('Movie DB : ', () {
    test('Test Insert Watchlist', () async {
      when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);

      final result = await databaseHelper.insertWatchlist(movieTable);

      expect(result, 1);
    });

    test('Get Data Movie watchlist', () async {
      when(mockDatabase.query(any))
          .thenAnswer((_) async => [movieTable.toJson()]);
      final result = await databaseHelper.getWatchlistMovies();

      expect(result, [movieTable.toJson()]);
    });

    test('Delete watchlist', () async {
      when(mockDatabase.delete(any, where: 'id =?', whereArgs: [1]))
          .thenAnswer((_) async => 1);

      final result = await databaseHelper.removeWatchlist(movieTable);
      expect(result, 1);
    });
  });

  group('TV DB : ', () {
    test('Test Insert Watchlist', () async {
      when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);

      final result = await databaseHelper.insertTVWatchlist(tvTable);

      expect(result, 1);
    });

    test('Get Data TV watchlist', () async {
      when(mockDatabase.query(any))
          .thenAnswer((_) async => [movieTable.toJson()]);
      final result = await databaseHelper.getWatchListTvSeries();

      expect(result, [tvTable.toJson()]);
    });

    test('Delete watchlist', () async {
      when(mockDatabase.delete(any, where: 'id =?', whereArgs: [1]))
          .thenAnswer((_) async => 1);

      final result = await databaseHelper.removeTVWatchlist(tvTable);
      expect(result, 1);
    });
  });
}
