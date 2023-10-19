part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

final class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

final class NowPlayingMoviesFailed extends NowPlayingMoviesState {
  final String message;
  const NowPlayingMoviesFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class NowPlayingMoviesSuccess extends NowPlayingMoviesState {
  final List<Movie> nowPlaying;
  const NowPlayingMoviesSuccess(this.nowPlaying);

  @override
  List<Object> get props => [nowPlaying];
}
