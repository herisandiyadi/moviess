import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc =
        WatchlistMovieBloc(watchlistMovies: mockGetWatchlistMovies);
  });
  group('Test Watchlist Movies : ', () {
    test('State Initial should be empty', () {
      expect(watchlistMovieBloc.state, WatchlistMovieInitial());
    });

    final tMovieList = <Movie>[testMovie];

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit Loading & Success when data is gotten succesfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(const FetchWatchlistMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieSuccess(tMovieList),
      ],
      verify: (bloc) => [
        verify(mockGetWatchlistMovies.execute()),
        const FetchWatchlistMovie().props,
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit Loading & Success when data is gotten unsuccesfully',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(const FetchWatchlistMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieFailed('Server Failure'),
      ],
      verify: (bloc) => [
        verify(mockGetWatchlistMovies.execute()),
        const FetchWatchlistMovie().props,
      ],
    );
  });
}
