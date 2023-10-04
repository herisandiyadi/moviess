import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_ontheair.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_populer.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_toprated.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesOnTheAir,
  GetTVSeriesPopuler,
  GetTvTopRated,
])
void main() {
  late TvListNotifier provider;
  late MockGetTvSeriesOnTheAir mockGetTvSeriesOnTheAir;
  late MockGetTVSeriesPopuler mockGetTVSeriesPopuler;
  late MockGetTvTopRated mockGetTvTopRated;
  late int listenerCallCount;
  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesPopuler = MockGetTVSeriesPopuler();
    mockGetTvSeriesOnTheAir = MockGetTvSeriesOnTheAir();
    mockGetTvTopRated = MockGetTvTopRated();
    provider = TvListNotifier(
      getTvSeriesOnTheAir: mockGetTvSeriesOnTheAir,
      getTVSeriesPopuler: mockGetTVSeriesPopuler,
      getTvTopRated: mockGetTvTopRated,
    )..addListener(() {
        listenerCallCount += 1;
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

  group('Tv Show : Now Playing Tv Show', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      when(mockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchOnTheAir();
      verify(mockGetTvSeriesOnTheAir.execute());
    });

    test('should change state to loading when usecase is called', () {
      when(mockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchOnTheAir();
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change tv show when data is gotten successfully', () async {
      when(mockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvList));

      await provider.fetchOnTheAir();

      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAir, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchOnTheAir();

      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Tv Show : Popular Tv Show', () {
    test('initialState should be Empty', () {
      expect(provider.popularTvState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchPopularTvShow();
      verify(mockGetTVSeriesPopuler.execute());
    });

    test('should change state to loading when usecase is called', () {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchPopularTvShow();
      expect(provider.popularTvState, RequestState.Loading);
    });

    test('should change tv show when data is gotten successfully', () async {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Right(tTvList));

      await provider.fetchPopularTvShow();

      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTvShow();

      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Tv Show : Top Rated Tv Show', () {
    test('initialState should be Empty', () {
      expect(provider.topRatedState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));

      provider.fetchTvTopRated();
      verify(mockGetTvTopRated.execute());
    });

    test('should change state to loading when usecase is called', () {
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));

      provider.fetchTvTopRated();
      expect(provider.topRatedState, RequestState.Loading);
    });

    test('should change tv show when data is gotten successfully', () async {
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));

      await provider.fetchTvTopRated();

      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTvTopRated();

      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
