import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_recomendations.dart';
import 'package:tv/domain/usecases/tvseries/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecomendations,
  GetWatchListTVStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecomendations mockGetTvRecomendations;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockGetWatchListTVStatus mockGetWatchListTVStatus;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecomendations = MockGetTvRecomendations();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetWatchListTVStatus = MockGetWatchListTVStatus();
    detailTvBloc = DetailTvBloc(
        getTvDetail: mockGetTvDetail,
        getTvRecomendations: mockGetTvRecomendations,
        removeWatchlistTv: mockRemoveWatchlistTv,
        saveWatchlistTv: mockSaveWatchlistTv,
        getWatchListTVStatus: mockGetWatchListTVStatus);
  });

  const tId = 1;

  group('Get Detail TV', () {
    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit DetailMovieLoading, Loaded, RecommendationLoading, RecommendationLoaded when get detail movie and recommendation movie successfuly',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTVDetail));
        when(mockGetTvRecomendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDetailTV(tId),
      ),
      expect: () => [
        DetailTvState.initial().copyWith(
          detailState: RequestState.Loading,
        ),
        DetailTvState.initial().copyWith(
          recommendationState: RequestState.Loading,
          detailState: RequestState.Loaded,
          tvDetail: testTVDetail,
        ),
        DetailTvState.initial().copyWith(
          detailState: RequestState.Loaded,
          tvDetail: testTVDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: testTvList,
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecomendations.execute(tId));
        const FetchDetailTV(tId).props;
      },
    );

    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit DetailMovieLoading, Error, RecommendationLoading, RecommendationLoaded when get detail movie and recommendation movie unsuccessfuly',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetTvRecomendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDetailTV(tId),
      ),
      expect: () => [
        DetailTvState.initial().copyWith(
          detailState: RequestState.Loading,
        ),
        DetailTvState.initial().copyWith(
          detailState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecomendations.execute(tId));
        const FetchDetailTV(tId).props;
      },
    );

    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit DetailMovieLoading, Loaded, RecommendationLoading, RecommendationLoaded when get detail movie Load and recommendation Error movie unsuccessfuly',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTVDetail));
        when(mockGetTvRecomendations.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDetailTV(tId),
      ),
      expect: () => [
        DetailTvState.initial().copyWith(
          detailState: RequestState.Loading,
        ),
        DetailTvState.initial().copyWith(
          detailState: RequestState.Loaded,
          recommendationState: RequestState.Loading,
          tvDetail: testTVDetail,
        ),
        DetailTvState.initial().copyWith(
            detailState: RequestState.Loaded,
            tvDetail: testTVDetail,
            recommendationState: RequestState.Error,
            message: 'Failed')
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecomendations.execute(tId));
        const FetchDetailTV(tId).props;
      },
    );
  });

  group(
    'Load Watchlist Status Movie',
    () {
      blocTest<DetailTvBloc, DetailTvState>(
        'Should Watchliststatus is true',
        build: () {
          when(mockGetWatchListTVStatus.execute(tId))
              .thenAnswer((_) async => true);
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(const StatusWatchlistTv(tId)),
        expect: () =>
            [DetailTvState.initial().copyWith(isAddedtoWatchlist: true)],
        verify: (_) => [
          verify(mockGetWatchListTVStatus.execute(tId)),
          const StatusWatchlistTv(tId).props,
        ],
      );

      blocTest<DetailTvBloc, DetailTvState>(
        'Should Watchliststatus is False',
        build: () {
          when(mockGetWatchListTVStatus.execute(tId))
              .thenAnswer((_) async => false);
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(const StatusWatchlistTv(tId)),
        expect: () =>
            [DetailTvState.initial().copyWith(isAddedtoWatchlist: false)],
        verify: (_) => [
          verify(mockGetWatchListTVStatus.execute(tId)),
          const StatusWatchlistTv(tId).props,
        ],
      );
    },
  );

  group('Added to Watchlist Movie', () {
    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit WatchlistMessage, isAddedtoWatchlist when success added to watchlist',
      build: () {
        when(mockSaveWatchlistTv.execute(testTVDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListTVStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => true);
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(
        const AddedWatchlistTv(testTVDetail),
      ),
      expect: () => [
        DetailTvState.initial()
            .copyWith(watchlistMessage: 'Added to Watchlist'),
        DetailTvState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedtoWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTv.execute(testTVDetail));
        verify(mockGetWatchListTVStatus.execute(testTVDetail.id));
        const AddedWatchlistTv(testTVDetail).props;
      },
    );

    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit WatchlistMessage when failed added to watchlist',
      build: () {
        when(mockSaveWatchlistTv.execute(testTVDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListTVStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => false);
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(
        const AddedWatchlistTv(testTVDetail),
      ),
      expect: () => [
        DetailTvState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTv.execute(testTVDetail));
        verify(mockGetWatchListTVStatus.execute(testTVDetail.id));
        const AddedWatchlistTv(testTVDetail).props;
      },
    );
  });

  group('Remove From Watchlist Movie', () {
    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit WatchlistMessage, isAddedtoWatchlist when success remove from watchlist',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTVDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListTVStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => false);
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(
        const RemoveFromWatchlistTv(testTVDetail),
      ),
      expect: () => [
        DetailTvState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedtoWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTv.execute(testTVDetail));
        verify(mockGetWatchListTVStatus.execute(testTVDetail.id));
        const RemoveFromWatchlistTv(testTVDetail).props;
      },
    );

    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit WatchlistMessage when failed remove from watchlist',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTVDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListTVStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => false);
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(
        const RemoveFromWatchlistTv(testTVDetail),
      ),
      expect: () => [
        DetailTvState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTv.execute(testTVDetail));
        verify(mockGetWatchListTVStatus.execute(testTVDetail.id));
        const RemoveFromWatchlistTv(testTVDetail).props;
      },
    );
  });
}
