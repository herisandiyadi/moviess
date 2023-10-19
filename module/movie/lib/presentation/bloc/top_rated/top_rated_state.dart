part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

final class TopRatedInitial extends TopRatedState {}

final class TopRatedLoading extends TopRatedState {}

final class TopRatedFailed extends TopRatedState {
  final String message;
  const TopRatedFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class TopRatedSuccess extends TopRatedState {
  final List<Movie> topRated;
  const TopRatedSuccess(this.topRated);

  @override
  List<Object> get props => [topRated];
}
