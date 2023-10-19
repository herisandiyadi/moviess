part of 'detail_tv_bloc.dart';

class DetailTvState extends Equatable {
  final TvDetail? tvDetail;
  final RequestState? detailState;
  final List<Tv>? tvRecommendations;
  final RequestState? recommendationState;
  final bool isAddedtoWatchlist;
  final String message;
  final String watchlistMessage;

  const DetailTvState({
    this.tvDetail,
    this.tvRecommendations,
    required this.detailState,
    this.recommendationState,
    required this.isAddedtoWatchlist,
    required this.message,
    required this.watchlistMessage,
  });

  @override
  List<Object?> get props => [
        tvDetail,
        detailState,
        tvRecommendations,
        recommendationState,
        isAddedtoWatchlist,
        message,
        watchlistMessage,
      ];

  DetailTvState copyWith({
    TvDetail? tvDetail,
    RequestState? detailState,
    List<Tv>? tvRecommendations,
    RequestState? recommendationState,
    bool? isAddedtoWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return DetailTvState(
        detailState: detailState ?? this.detailState,
        tvDetail: tvDetail ?? this.tvDetail,
        tvRecommendations: tvRecommendations ?? this.tvRecommendations,
        isAddedtoWatchlist: isAddedtoWatchlist ?? this.isAddedtoWatchlist,
        message: message ?? this.message,
        watchlistMessage: watchlistMessage ?? this.watchlistMessage,
        recommendationState: recommendationState ?? this.recommendationState);
  }

  factory DetailTvState.initial() {
    return const DetailTvState(
      recommendationState: RequestState.Empty,
      detailState: RequestState.Empty,
      isAddedtoWatchlist: false,
      message: '',
      watchlistMessage: '',
      tvDetail: null,
      tvRecommendations: [],
    );
  }
}
