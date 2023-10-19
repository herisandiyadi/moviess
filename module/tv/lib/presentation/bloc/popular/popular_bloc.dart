import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_populer.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularTvBloc extends Bloc<PopularEvent, PopularState> {
  final GetTVSeriesPopuler getTVSeriesPopuler;
  PopularTvBloc({required this.getTVSeriesPopuler}) : super(PopularInitial()) {
    on<FetchPopularTv>((event, emit) async {
      emit(PopularLoading());
      final result = await getTVSeriesPopuler.execute();

      result.fold(
        (failure) => emit(
          PopularFailed(failure.message),
        ),
        (popularData) => emit(
          PopularSuccess(popularData),
        ),
      );
    });
  }
}
