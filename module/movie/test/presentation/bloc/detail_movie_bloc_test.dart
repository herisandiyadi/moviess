import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/detail_movie/detail_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    detailMovieBloc = DetailMovieBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  const tId = 1;

  group('Get Detail Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit DetailMovieLoading, Loaded, RecommendationLoading, RecommendationLoaded when get detail movie and recommendation movie successfuly',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDetailMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          detailState: RequestState.Loading,
        ),
        DetailMovieState.initial().copyWith(
          recommendationsState: RequestState.Loading,
          detailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
          detailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          recommendationsState: RequestState.Loaded,
          movieRecommendations: testMovieList,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
        const FetchDetailMovie(tId).props;
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit DetailMovieLoading, Error, RecommendationLoading, RecommendationLoaded when get detail movie and recommendation movie unsuccessfuly',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDetailMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          detailState: RequestState.Loading,
        ),
        DetailMovieState.initial().copyWith(
          detailState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
        const FetchDetailMovie(tId).props;
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit DetailMovieLoading, Loaded, RecommendationLoading, RecommendationLoaded when get detail movie Load and recommendation Error movie unsuccessfuly',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDetailMovie(tId),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          detailState: RequestState.Loading,
        ),
        DetailMovieState.initial().copyWith(
          detailState: RequestState.Loaded,
          recommendationsState: RequestState.Loading,
          movieDetail: testMovieDetail,
        ),
        DetailMovieState.initial().copyWith(
            detailState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            recommendationsState: RequestState.Error,
            message: 'Failed')
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
        const FetchDetailMovie(tId).props;
      },
    );
  });

  group(
    'Load Watchlist Status Movie',
    () {
      blocTest<DetailMovieBloc, DetailMovieState>(
        'Should Watchliststatus is true',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const StatusWatchlistMovie(tId)),
        expect: () =>
            [DetailMovieState.initial().copyWith(isAddedToWatchlist: true)],
        verify: (_) => [
          verify(mockGetWatchListStatus.execute(tId)),
          const StatusWatchlistMovie(tId).props,
        ],
      );

      blocTest<DetailMovieBloc, DetailMovieState>(
        'Should Watchliststatus is False',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const StatusWatchlistMovie(tId)),
        expect: () =>
            [DetailMovieState.initial().copyWith(isAddedToWatchlist: false)],
        verify: (_) => [
          verify(mockGetWatchListStatus.execute(tId)),
          const StatusWatchlistMovie(tId).props,
        ],
      );
    },
  );

  group('Added to Watchlist Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit WatchlistMessage, isAddedtoWatchlist when success added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        const AddedWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial()
            .copyWith(watchlistMessage: 'Added to Watchlist'),
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        const AddedWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit WatchlistMessage when failed added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        const AddedWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        const AddedWatchlistMovie(testMovieDetail).props;
      },
    );
  });

  group('Remove From Watchlist Movie', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit WatchlistMessage, isAddedtoWatchlist when success remove from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        const RemoveFromWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        const RemoveFromWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit WatchlistMessage when failed remove from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(
        const RemoveFromWatchlistMovie(testMovieDetail),
      ),
      expect: () => [
        DetailMovieState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        const RemoveFromWatchlistMovie(testMovieDetail).props;
      },
    );
  });
}
