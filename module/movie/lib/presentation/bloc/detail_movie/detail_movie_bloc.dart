import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/entitites/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  static const addWatchlistMessage = 'Added to Watchlist';
  static const removeWatchlistMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  DetailMovieBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(DetailMovieState.initial()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(state.copyWith(detailState: RequestState.Loading));

      final id = event.id;
      final detailResult = await getMovieDetail.execute(id);
      final recommendationResult = await getMovieRecommendations.execute(id);

      detailResult.fold(
        (failure) {
          emit(
            state.copyWith(
              detailState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (detailMovie) {
          emit(
            state.copyWith(
                movieDetail: detailMovie,
                detailState: RequestState.Loaded,
                recommendationsState: RequestState.Loading,
                watchlistMessage: ''),
          );
          recommendationResult.fold((failure) {
            emit(
              state.copyWith(
                recommendationsState: RequestState.Error,
                message: failure.message,
              ),
            );
          }, (movieRecommendation) {
            if (movieRecommendation.isEmpty) {
              emit(
                state.copyWith(
                  recommendationsState: RequestState.Empty,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  recommendationsState: RequestState.Loaded,
                  movieRecommendations: movieRecommendation,
                ),
              );
            }
          });
        },
      );
    });

    on<AddedWatchlistMovie>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final result = await saveWatchlist.execute(movieDetail);

        result.fold(
          (failure) => emit(
            state.copyWith(
              watchlistMessage: failure.message,
            ),
          ),
          (successMessage) => emit(
            state.copyWith(
              watchlistMessage: successMessage,
            ),
          ),
        );
        add(StatusWatchlistMovie(movieDetail.id));
      },
    );

    on<RemoveFromWatchlistMovie>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await removeWatchlist.execute(movieDetail);

      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) => emit(
          state.copyWith(
            watchlistMessage: successMessage,
          ),
        ),
      );
      add(StatusWatchlistMovie(movieDetail.id));
    });

    on<StatusWatchlistMovie>((event, emit) async {
      final status = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: status));
    });
  }
}
