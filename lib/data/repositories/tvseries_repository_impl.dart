import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_datasource.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TvSeriesRepositoryImpl implements TVRepository {
  final TVRemoteDataSource tvRemoteDataSource;
  final TvLocalDataSource tvLocalDataSource;
  final NetworkInfo networkInfo;
  final DatabaseHelper databaseHelper;

  TvSeriesRepositoryImpl({
    required this.tvRemoteDataSource,
    required this.tvLocalDataSource,
    required this.databaseHelper,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Tv>>> getTvSeriesOnTheAir() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await tvRemoteDataSource.getTvSeriesOnTheAir();
        tvLocalDataSource.cacheNowPlayingTvSeries(result.map((e) {
          final data = TvTable.fromDTO(e);

          return data;
        }).toList());

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      } on SocketException {
        return Left(ConnectionFailure('Failed connect to the network'));
      }
    } else {
      try {
        final result = await tvLocalDataSource.getCachedNowPlayingTv();
        return Right(result.map((e) => e.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvSeriesPopuler() async {
    try {
      final result = await tvRemoteDataSource.getTVSeriesPopuler();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network'));
    }
  }

  Future<Either<Failure, List<Tv>>> getTvRecomendations(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvRecomendations(id);

      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvTopRated() async {
    try {
      final result = await tvRemoteDataSource.getTvSeriesTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvDetail(id);

      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTvShow(String query) async {
    try {
      final result = await tvRemoteDataSource.searchTvShow(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await tvLocalDataSource.getWatchlistTvSeries();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedtoWatchList(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv) async {
    try {
      final result =
          await tvLocalDataSource.removeTvWatchlist(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchListTv(TvDetail tv) async {
    try {
      final result =
          await tvLocalDataSource.insertTvWatchlist(TvTable.fromEntity(tv));

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> cacheNowPlayingTv(List<Tv> tv) async {
    await databaseHelper.clearCacheTv('on the air');
    final dataTv = tv.map((e) => TvTable.cache(e)).toList();
    await databaseHelper.insertCacheTvTransaction(dataTv, 'on the air');
  }

  @override
  Future<Either<Failure, List<Tv>>> getCachedNowPlayingTv() async {
    try {
      final result = await databaseHelper.getCacheTv('on the air');
      if (result.length > 0) {
        final dataTv = result.map((e) => TvTable.fromMap(e)).toList();
        final dataResult = dataTv.map((e) => e.toEntity()).toList();
        return Right(dataResult);
      } else {
        return Left(CacheFailure('No Cache'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
