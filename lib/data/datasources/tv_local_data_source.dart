import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tvseries_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertTvWatchlist(TvTable tv);
  Future<String> removeTvWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvSeries();
  Future<void> cacheNowPlayingTvSeries(List<TvTable> tv);
  Future<List<TvTable>> getCachedNowPlayingTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;
  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchListTvSeries();
    return result.map((e) => TvTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTVWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTVWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheNowPlayingTvSeries(List<TvTable> tv) async {
    await databaseHelper.clearCache('on the air');
    await databaseHelper.insertCacheTvTransaction(tv, 'on the air');
  }

  @override
  Future<List<TvTable>> getCachedNowPlayingTv() async {
    final result = await databaseHelper.getCacheTv('on the air');
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException('Cant get the data: (');
    }
  }
}
