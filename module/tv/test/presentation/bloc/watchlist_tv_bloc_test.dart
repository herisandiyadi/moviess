import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchlistTvBloc = WatchlistTvBloc(getWatchlistTv: mockGetWatchlistTv);
  });

  group('Test Watchlist TV : ', () {
    test('State Initial should be empty', () {
      expect(watchlistTvBloc.state, WatchlistTvInitial());
    });

    final tTvList = <Tv>[tTvShow];

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit Loading & Success when data is gotten succesfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const FetchWatchlistTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvSuccess(tTvList),
      ],
      verify: (bloc) => [
        verify(mockGetWatchlistTv.execute()),
        const FetchWatchlistTv().props,
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit Loading & Success when data is gotten unsuccesfully',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const FetchWatchlistTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvFailed('Server Failure'),
      ],
      verify: (bloc) => [
        verify(mockGetWatchlistTv.execute()),
        const FetchWatchlistTv().props,
      ],
    );
  });
}
