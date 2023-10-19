import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tvseries/remove_watchlist_tv.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = RemoveWatchlistTv(mockTVRepository);
  });

  test('should remove watchlist Tv Series from repository', () async {
    when(mockTVRepository.removeWatchlist(testTVDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));

    final result = await usecase.execute(testTVDetail);

    verify(mockTVRepository.removeWatchlist(testTVDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
