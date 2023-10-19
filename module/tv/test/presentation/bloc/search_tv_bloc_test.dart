import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/search_tvshow.dart';
import 'package:tv/presentation/bloc/search_tv/search_tv_bloc.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvShow])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvShow mockSearchTvShow;

  setUp(() {
    mockSearchTvShow = MockSearchTvShow();
    searchTvBloc = SearchTvBloc(searchTvShow: mockSearchTvShow);
  });

  const tTvModel = Tv(
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    firstAirDate: "1952-12-26",
    genreIds: [10763],
    id: 94722,
    name: "Tagesschau",
    originCountry: ["DE"],
    originalLanguage: 'de',
    originalName: "Tagesschau",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    popularity: 3359.88,
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    voteAverage: 7.5,
    voteCount: 143,
  );

  final tTvList = <Tv>[tTvModel];
  const tQuery = 'tagesschau';

  group('Search TV Test : ', () {
    blocTest(
      'Should emit Loading & Success when data is gotten succesfully',
      build: () {
        when(mockSearchTvShow.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(const FetchSearchTv(tQuery)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        SearchTvLoading(),
        SearchTvSuccess(tTvList),
      ],
      verify: (bloc) => [
        verify(mockSearchTvShow.execute(tQuery)),
        const FetchSearchTv(tQuery).props
      ],
    );

    blocTest(
      'Should emit Loading & Success when data is gotten unsuccesfully',
      build: () {
        when(mockSearchTvShow.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(const FetchSearchTv(tQuery)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        SearchTvLoading(),
        const SearchTvFailed('Server Failure'),
      ],
      verify: (bloc) => [
        verify(mockSearchTvShow.execute(tQuery)),
        const FetchSearchTv(tQuery).props
      ],
    );
  });
}
