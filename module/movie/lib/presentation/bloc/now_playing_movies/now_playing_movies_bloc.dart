import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMoviesBloc({required this.getNowPlayingMovies})
      : super(NowPlayingMoviesInitial()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(
          NowPlayingMoviesFailed(failure.message),
        ),
        (nowPlaying) => emit(
          NowPlayingMoviesSuccess(nowPlaying),
        ),
      );
    });
  }
}
