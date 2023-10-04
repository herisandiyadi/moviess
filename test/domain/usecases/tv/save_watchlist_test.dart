import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tv_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SaveWatchlistTv(mockTVRepository);
  });

  test('should save Tv Series to the repository', () async {
    when(mockTVRepository.saveWatchListTv(testTVDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));

    final result = await usecase.execute(testTVDetail);

    verify(mockTVRepository.saveWatchListTv(testTVDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
