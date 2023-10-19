import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies watchlistMovies;
  WatchlistMovieBloc({required this.watchlistMovies})
      : super(WatchlistMovieInitial()) {
    on<FetchWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await watchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMovieFailed(failure.message)),
        (watchlistData) => emit(
          WatchlistMovieSuccess(watchlistData),
        ),
      );
    });
  }
}
