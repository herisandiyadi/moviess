import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvshow.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShow])
void main() {
  late TvSearchNotifier provider;
  late int listenerCallCount;
  late MockSearchTvShow mockSearchTvShow;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShow = MockSearchTvShow();
    provider = TvSearchNotifier(searchTvShow: mockSearchTvShow)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvModel = Tv(
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
  final tQuery = 'tagesschau';

  group('TV Show : Search Tv', () {
    test('should change state to loading when usecase is called', () async {
      when(mockSearchTvShow.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchTvSearch(tQuery);

      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      when(mockSearchTvShow.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));

      await provider.fetchTvSearch(tQuery);

      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockSearchTvShow.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTvSearch(tQuery);

      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
