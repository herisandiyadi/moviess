import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_recomendations.dart';
import 'package:tv/domain/usecases/tvseries/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/tvseries/save_watchlist_tv.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  static const addWatchlistMessage = 'Added to Watchlist';
  static const removeWatchlistMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecomendations getTvRecomendations;
  final GetWatchListTVStatus getWatchListTVStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  DetailTvBloc({
    required this.getTvDetail,
    required this.getTvRecomendations,
    required this.getWatchListTVStatus,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
  }) : super(DetailTvState.initial()) {
    on<FetchDetailTV>(
      (event, emit) async {
        emit(state.copyWith(detailState: RequestState.Loading));

        final id = event.id;
        final detailResult = await getTvDetail.execute(id);
        final recommendationResult = await getTvRecomendations.execute(id);

        detailResult.fold((failure) {
          emit(
            state.copyWith(
              detailState: RequestState.Error,
              message: failure.message,
            ),
          );
        }, (detailTv) {
          emit(
            state.copyWith(
                tvDetail: detailTv,
                detailState: RequestState.Loaded,
                recommendationState: RequestState.Loading,
                watchlistMessage: ''),
          );
          recommendationResult.fold((failure) {
            emit(
              state.copyWith(
                recommendationState: RequestState.Error,
                message: failure.message,
              ),
            );
          }, (recommendationData) {
            if (recommendationData.isEmpty) {
              emit(
                state.copyWith(recommendationState: RequestState.Empty),
              );
            } else {
              emit(
                state.copyWith(
                  recommendationState: RequestState.Loaded,
                  tvRecommendations: recommendationData,
                ),
              );
            }
          });
        });
      },
    );

    on<AddedWatchlistTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await saveWatchlistTv.execute(tvDetail);

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
      add(StatusWatchlistTv(tvDetail.id!));
    });

    on<RemoveFromWatchlistTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await removeWatchlistTv.execute(tvDetail);

      result.fold(
          (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
          (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });
      add(StatusWatchlistTv(tvDetail.id!));
    });

    on<StatusWatchlistTv>((event, emit) async {
      final status = await getWatchListTVStatus.execute(event.id);
      emit(
        state.copyWith(
          isAddedtoWatchlist: status,
        ),
      );
    });
  }
}
