import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_populer.dart';
import 'package:ditonton/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTVSeriesPopuler])
void main() {
  late PopularTVNotifier provider;
  late int listenerCallCount;
  late MockGetTVSeriesPopuler mockGetTVSeriesPopuler;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesPopuler = MockGetTVSeriesPopuler();
    provider = PopularTVNotifier(mockGetTVSeriesPopuler)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  group('TV Series : Popular', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchPopularTvShow();
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show data when data is gotten successfully',
        () async {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Right(tTvList));

      await provider.fetchPopularTvShow();
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvShow, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTvShow();

      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
