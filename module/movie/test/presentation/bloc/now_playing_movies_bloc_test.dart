import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc =
        NowPlayingMoviesBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  test('State Initial should be empty', () {
    expect(nowPlayingMoviesBloc.state, NowPlayingMoviesInitial());
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit Loading & Success when data is gotten succesfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesSuccess(tMovieList),
    ],
    verify: (_) => [
      verify(mockGetNowPlayingMovies.execute()),
      const FetchNowPlayingMovies().props
    ],
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit Loading & Failed when data is gotten unsuccesfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesFailed('Server Failure'),
    ],
    verify: (bloc) => [
      verify(mockGetNowPlayingMovies.execute()),
      const FetchNowPlayingMovies().props,
    ],
  );
}
