import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_ontheair.dart';

part 'on_the_air_event.dart';
part 'on_the_air_state.dart';

class OnTheAirBloc extends Bloc<OnTheAirEvent, OnTheAirState> {
  final GetTvSeriesOnTheAir getOnTheAir;
  OnTheAirBloc({required this.getOnTheAir}) : super(OnTheAirInitial()) {
    on<FetchOnTheAirTv>((event, emit) async {
      emit(OnTheAirLoading());
      final result = await getOnTheAir.execute();
      result.fold(
        (failure) => emit(
          OnTheAirFailed(failure.message),
        ),
        (onTheAir) => emit(
          OnTheAirSuccess(onTheAir),
        ),
      );
    });
  }
}
