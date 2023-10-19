import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;
  SearchMovieBloc({required this.searchMovies}) : super(SearchMovieInitial()) {
    on<FetchSearchMovie>((event, emit) async {
      emit(SearchMovieLoading());
      final query = event.query;
      final result = await searchMovies.execute(query);
      result.fold(
          (failure) => emit(
                SearchMovieFailed(failure.message),
              ), (data) {
        if (data.isEmpty) {
          emit(SearchMovieInitial());
        } else {
          emit(
            SearchMovieSuccess(data),
          );
        }
      });
    });
  }
}
