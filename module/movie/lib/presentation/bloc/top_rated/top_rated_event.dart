part of 'top_rated_bloc.dart';

abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();
}

class FetchTopRatedMovies extends TopRatedEvent {
  const FetchTopRatedMovies();

  @override
  List<Object?> get props => [];
}
