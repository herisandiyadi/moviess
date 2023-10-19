import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular/popular_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularBloc popularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularBloc = PopularBloc(getPopularMovies: mockGetPopularMovies);
  });

  test('State initial should be empty', () {
    expect(popularBloc.state, PopularInitial());
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<PopularBloc, PopularState>(
    'Should emit Loading & Success when data is gotten succesfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [PopularLoading(), PopularSuccess(tMovieList)],
    verify: (bloc) => [
      verify(mockGetPopularMovies.execute()),
      const FetchPopularMovies().props,
    ],
  );

  blocTest<PopularBloc, PopularState>(
    'Should emit Loading & Failed when data is gotten unsuccesfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [PopularLoading(), const PopularFailed('Server Failure')],
    verify: (bloc) => [
      verify(mockGetPopularMovies.execute()),
      const FetchPopularMovies().props,
    ],
  );
}
