part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();
}

class FetchPopularMovies extends PopularEvent {
  const FetchPopularMovies();

  @override
  List<Object?> get props => [];
}
