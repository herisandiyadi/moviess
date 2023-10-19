import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedBloc topRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  test('State Initial should be empty', () {
    expect(topRatedBloc.state, TopRatedInitial());
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<TopRatedBloc, TopRatedState>(
    'Should emit Loading & Success when data is gotten succesfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));

      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedLoading(),
      TopRatedSuccess(tMovieList),
    ],
    verify: (bloc) => [
      verify(mockGetTopRatedMovies.execute()),
      const FetchTopRatedMovies().props,
    ],
  );

  blocTest<TopRatedBloc, TopRatedState>(
    'Should emit Loading & Success when data is gotten unsuccesfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedLoading(),
      const TopRatedFailed('Server Failure'),
    ],
    verify: (bloc) => [
      verify(mockGetTopRatedMovies.execute()),
      const FetchTopRatedMovies().props,
    ],
  );
}
