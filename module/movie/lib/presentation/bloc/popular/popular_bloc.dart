import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies getPopularMovies;
  PopularBloc({required this.getPopularMovies}) : super(PopularInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularLoading());
      final result = await getPopularMovies.execute();

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
