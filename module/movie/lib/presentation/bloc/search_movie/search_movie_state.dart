part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

final class SearchMovieInitial extends SearchMovieState {}

final class SearchMovieLoading extends SearchMovieState {}

final class SearchMovieFailed extends SearchMovieState {
  final String message;
  const SearchMovieFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchMovieSuccess extends SearchMovieState {
  final List<Movie> movie;
  const SearchMovieSuccess(this.movie);

  @override
  List<Object> get props => [movie];
}
