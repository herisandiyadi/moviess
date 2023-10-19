import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv getWatchlistTv;
  WatchlistTvBloc({required this.getWatchlistTv})
      : super(WatchlistTvInitial()) {
    on<FetchWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await getWatchlistTv.execute();

      result.fold(
          (failure) => emit(
                WatchlistTvFailed(failure.message),
              ), (watchlistData) {
        if (watchlistData.isEmpty) {
          emit(WatchlistTvInitial());
        } else {
          emit(WatchlistTvSuccess(watchlistData));
        }
      });
    });
  }
}
