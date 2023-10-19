part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;
  const FetchDetailMovie(this.id);

  @override
  List<Object?> get props => [id];
}

class AddedWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;
  const AddedWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;
  const RemoveFromWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class StatusWatchlistMovie extends DetailMovieEvent {
  final int id;

  const StatusWatchlistMovie(this.id);
  @override
  List<Object?> get props => [id];
}
