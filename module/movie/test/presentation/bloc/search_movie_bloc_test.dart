import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/search_movie/search_movie_bloc.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(searchMovies: mockSearchMovies);
  });

  const tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  blocTest(
    'Should emit Loading & Success when data is gotten succesfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchSearchMovie(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieSuccess(tMovieList),
    ],
    verify: (bloc) => [
      verify(mockSearchMovies.execute(tQuery)),
      const FetchSearchMovie(tQuery).props
    ],
  );

  blocTest(
    'Should emit Loading & Success when data is gotten unsuccesfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchSearchMovie(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchMovieLoading(),
      const SearchMovieFailed('Server Failure'),
    ],
    verify: (bloc) => [
      verify(mockSearchMovies.execute(tQuery)),
      const FetchSearchMovie(tQuery).props
    ],
  );
}
