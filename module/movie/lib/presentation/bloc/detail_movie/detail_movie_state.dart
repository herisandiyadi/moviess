part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState? detailState;
  final List<Movie>? movieRecommendations;
  final RequestState? recommendationsState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const DetailMovieState(
      {this.movieDetail,
      required this.detailState,
      this.movieRecommendations,
      this.recommendationsState,
      required this.isAddedToWatchlist,
      required this.message,
      required this.watchlistMessage});

  @override
  List<Object?> get props => [
        movieDetail,
        detailState,
        movieRecommendations,
        recommendationsState,
        isAddedToWatchlist,
        message,
        watchlistMessage,
      ];

  DetailMovieState copyWith({
    MovieDetail? movieDetail,
    RequestState? detailState,
    List<Movie>? movieRecommendations,
    RequestState? recommendationsState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return DetailMovieState(
        movieDetail: movieDetail ?? this.movieDetail,
        detailState: detailState ?? this.detailState,
        movieRecommendations: movieRecommendations ?? this.movieRecommendations,
        recommendationsState: recommendationsState ?? this.recommendationsState,
        message: message ?? this.message,
        watchlistMessage: watchlistMessage ?? this.watchlistMessage,
        isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist);
  }

  factory DetailMovieState.initial() {
    return const DetailMovieState(
      recommendationsState: RequestState.Empty,
      detailState: RequestState.Empty,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
      movieDetail: null,
      movieRecommendations: [],
    );
  }
}
