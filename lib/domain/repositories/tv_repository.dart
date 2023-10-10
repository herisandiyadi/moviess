import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<Tv>>> getTvSeriesPopuler();
  Future<Either<Failure, List<Tv>>> getTvTopRated();
  Future<Either<Failure, List<Tv>>> getTvSeriesOnTheAir();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> searchTvShow(String query);
  Future<Either<Failure, String>> saveWatchListTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);
  Future<bool> isAddedtoWatchList(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
  Future<void> cacheNowPlayingTv(List<Tv> tv);
  Future<Either<Failure, List<Tv>>> getCachedNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getTvRecomendations(int id);
}
