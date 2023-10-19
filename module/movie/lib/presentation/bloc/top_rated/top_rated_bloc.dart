import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedBloc({required this.getTopRatedMovies}) : super(TopRatedInitial()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedLoading());

      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) => emit(TopRatedFailed(failure.message)),
        (topRated) => emit(
          TopRatedSuccess(topRated),
        ),
      );
    });
  }
}
