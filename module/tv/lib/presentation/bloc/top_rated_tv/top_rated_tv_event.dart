part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvEvent extends Equatable {
  const TopRatedTvEvent();
}

class FetchTopRatedTv extends TopRatedTvEvent {
  const FetchTopRatedTv();

  @override
  List<Object?> get props => [];
}
