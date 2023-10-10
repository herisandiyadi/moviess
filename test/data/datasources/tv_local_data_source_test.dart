import 'package:ditonton/data/datasources/tv_local_data_source.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/common/exception.dart';
import '../../dummy_data/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl datasource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    datasource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Save watchlist', () {
    test('should return succcess message ehen insert to database is success',
        () async {
      when(mockDatabaseHelper.insertTVWatchlist(testTvTable))
          .thenAnswer((_) async => 1);

      final result = await datasource.insertTvWatchlist(testTvTable);

      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = datasource.insertTvWatchlist(testTvTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeTVWatchlist(testTvTable))
          .thenAnswer((_) async => 1);

      final result = await datasource.removeTvWatchlist(testTvTable);

      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDatabaseHelper.removeTVWatchlist(testTvTable))
          .thenThrow(Exception());

      final call = datasource.removeTvWatchlist(testTvTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series Detail by Id', () {
    final tId = 1;

    test('should return Tv Series Detail table when data is found', () async {
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvMap);

      final result = await datasource.getTvById(tId);

      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      final result = await datasource.getTvById(tId);

      expect(result, null);
    });
  });

  group('Get watchlist Tv Series', () {
    test('should return list of TvTable from database', () async {
      when(mockDatabaseHelper.getWatchListTvSeries())
          .thenAnswer((_) async => [testTvMap]);

      final result = await datasource.getWatchlistTvSeries();

      expect(result, [testTvTable]);
    });
  });
}
