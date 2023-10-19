part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
}

class FetchSearchMovie extends SearchMovieEvent {
  final String query;

  const FetchSearchMovie(this.query);

  @override
  List<Object?> get props => [query];
}
