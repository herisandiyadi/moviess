import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_toprated.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTvTopRated getTvTopRated;
  TopRatedTvBloc({required this.getTvTopRated}) : super(TopRatedTvInitial()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await getTvTopRated.execute();
      result.fold(
        (failure) => emit(
          TopRatedTvFailed(failure.message),
        ),
        (topratedData) => emit(
          TopRatedTvSuccess(topratedData),
        ),
      );
    });
  }
}
