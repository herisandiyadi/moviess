import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tvseries/save_watchlist_tv.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SaveWatchlistTv(mockTVRepository);
  });

  test('should save Tv Series to the repository', () async {
    when(mockTVRepository.saveWatchListTv(testTVDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));

    final result = await usecase.execute(testTVDetail);

    verify(mockTVRepository.saveWatchListTv(testTVDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
