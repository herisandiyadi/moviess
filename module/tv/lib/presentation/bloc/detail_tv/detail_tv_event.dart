part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();
}

class FetchDetailTV extends DetailTvEvent {
  final int id;
  const FetchDetailTV(this.id);

  @override
  List<Object?> get props => [id];
}

class AddedWatchlistTv extends DetailTvEvent {
  final TvDetail tvDetail;
  const AddedWatchlistTv(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class RemoveFromWatchlistTv extends DetailTvEvent {
  final TvDetail tvDetail;
  const RemoveFromWatchlistTv(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class StatusWatchlistTv extends DetailTvEvent {
  final int id;
  const StatusWatchlistTv(this.id);

  @override
  List<Object?> get props => [id];
}
