part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

final class WatchlistMovieLoading extends WatchlistMovieState {}

final class WatchlistMovieFailed extends WatchlistMovieState {
  final String message;
  const WatchlistMovieFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchlistMovieSuccess extends WatchlistMovieState {
  final List<Movie> watchListMovie;
  const WatchlistMovieSuccess(this.watchListMovie);

  @override
  List<Object> get props => [watchListMovie];
}
