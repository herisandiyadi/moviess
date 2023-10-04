import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tv_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvNotifier provider;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchlistTv();
    provider = WatchlistTvNotifier(getWatchlistTv: mockGetWatchlistTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('TV Show : Watchlist', () {
    test('should change Tv show data when data is gotten successfully',
        () async {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right([testWatchlistTV]));

      await provider.fetchWatchlistTv();

      expect(provider.watchlistState, RequestState.Loaded);
      expect(provider.watchlistTv, [testWatchlistTV]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Cant get data')));

      await provider.fetchWatchlistTv();
      expect(provider.watchlistState, RequestState.Error);
      expect(provider.message, 'Cant get data');
      expect(listenerCallCount, 2);
    });
  });
}
