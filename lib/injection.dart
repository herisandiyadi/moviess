import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_datasource.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/utils/network_connection.dart';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_cached_now_playingmovie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular/popular_bloc.dart';
import 'package:movie/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/tvseries/get_cache_now_playingtv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_recomendations.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_ontheair.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_populer.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_toprated.dart';
import 'package:tv/domain/usecases/tvseries/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/tvseries/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:tv/domain/usecases/tvseries/search_tvshow.dart';
import 'package:tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/popular/popular_bloc.dart';
import 'package:tv/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      getNowPlayingMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularBloc(
      getPopularMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedBloc(
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => DetailMovieBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMovieBloc(
      watchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchMovieBloc(
      searchMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => OnTheAirBloc(
      getOnTheAir: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      getTVSeriesPopuler: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(
      getTvTopRated: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvBloc(
      getWatchlistTv: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvBloc(
      searchTvShow: locator(),
    ),
  );

  locator.registerFactory(
    () => DetailTvBloc(
      getTvDetail: locator(),
      getTvRecomendations: locator(),
      getWatchListTVStatus: locator(),
      removeWatchlistTv: locator(),
      saveWatchlistTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetCachedNowPlayingMovie(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => SearchTvShow(locator()));
  locator.registerLazySingleton(() => GetCacheNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetTvSeriesOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTVSeriesPopuler(locator()));
  locator.registerLazySingleton(() => GetTvTopRated(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecomendations(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTVStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
      databaseHelper: locator(),
    ),
  );

  locator.registerLazySingleton<TVRepository>(
    () => TvSeriesRepositoryImpl(
      tvRemoteDataSource: locator(),
      tvLocalDataSource: locator(),
      databaseHelper: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDatasourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
  locator.registerLazySingleton(() => DataConnectionChecker());

  //network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
}
