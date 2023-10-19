part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvInitial extends TopRatedTvState {}

final class TopRatedTvLoading extends TopRatedTvState {}

final class TopRatedTvFailed extends TopRatedTvState {
  final String message;
  const TopRatedTvFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class TopRatedTvSuccess extends TopRatedTvState {
  final List<Tv> toprated;
  const TopRatedTvSuccess(this.toprated);

  @override
  List<Object> get props => [toprated];
}
