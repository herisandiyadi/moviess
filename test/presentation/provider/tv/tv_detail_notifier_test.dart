import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tv_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecomendations,
  GetWatchListTVStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecomendations mockGetTvRecomendations;
  late MockGetWatchListTVStatus mockGetWatchListTVStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecomendations = MockGetTvRecomendations();
    mockGetWatchListTVStatus = MockGetWatchListTVStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecomendations: mockGetTvRecomendations,
      getWatchListTVStatus: mockGetWatchListTVStatus,
      removeWatchlistTv: mockRemoveWatchlistTv,
      saveWatchlistTv: mockSaveWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
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

  final tTvShow = <Tv>[tTv];

  void _arrangeUseCase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetail));

    when(mockGetTvRecomendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShow));
  }

  group('Get Tv Show Detail', () {
    test('should get data from usecase', () async {
      _arrangeUseCase();

      await provider.fetchTvDetail(tId);

      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecomendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      _arrangeUseCase();

      provider.fetchTvDetail(tId);

      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      _arrangeUseCase();

      await provider.fetchTvDetail(tId);
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvDetail, testTVDetail);
      expect(listenerCallCount, 3);
    });

    test('should chane recommendation tv show when data is gotten successfully',
        () async {
      _arrangeUseCase();

      await provider.fetchTvDetail(tId);
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecomendations, tTvShow);
    });
  });

  group('Get TV SHow Recommendations', () {
    test('should get data from the usecase', () async {
      _arrangeUseCase();

      await provider.fetchTvDetail(tId);

      verify(mockGetTvRecomendations.execute(tId));
      expect(provider.tvRecomendations, tTvShow);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      _arrangeUseCase();

      await provider.fetchTvDetail(tId);
      expect(provider.recomendationState, RequestState.Loaded);
      expect(provider.tvRecomendations, tTvShow);
    });

    test('should update error message when request in successful', () async {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVDetail));
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      await provider.fetchTvDetail(tId);

      expect(provider.recomendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('TV Show : Watchlist', () {
    test('should get the watchlist status', () async {
      when(mockGetWatchListTVStatus.execute(1)).thenAnswer((_) async => true);

      await provider.loadWatchlistStatus(1);

      expect(provider.isAddedtoWatchList, true);
    });

    test('should execute save watchlist when function called', () async {
      when(mockSaveWatchlistTv.execute(testTVDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListTVStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);

      await provider.addWatchlist(testTVDetail);
      verify(mockSaveWatchlistTv.execute(testTVDetail));
    });

    test('should execute remove watchlist when function called', () async {
      when(mockRemoveWatchlistTv.execute(testTVDetail))
          .thenAnswer((_) async => Right('Removed'));

      when(mockGetWatchListTVStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);

      await provider.removeFromWatchlist(testTVDetail);

      verify(mockRemoveWatchlistTv.execute(testTVDetail));
    });

    test('should update watchlist message when add watchlist failed', () async {
      when(mockSaveWatchlistTv.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));

      when(mockGetWatchListTVStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);

      await provider.addWatchlist(testTVDetail);

      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('Tv Show : On Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShow));

      await provider.fetchTvDetail(tId);

      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
