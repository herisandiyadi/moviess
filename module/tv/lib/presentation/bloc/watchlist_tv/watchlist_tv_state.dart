part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

final class WatchlistTvInitial extends WatchlistTvState {}

final class WatchlistTvLoading extends WatchlistTvState {}

final class WatchlistTvFailed extends WatchlistTvState {
  final String message;
  const WatchlistTvFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchlistTvSuccess extends WatchlistTvState {
  final List<Tv> watchList;
  const WatchlistTvSuccess(this.watchList);

  @override
  List<Object> get props => [watchList];
}
