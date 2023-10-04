import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tv_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = RemoveWatchlistTv(mockTVRepository);
  });

  test('should remove watchlist Tv Series from repository', () async {
    when(mockTVRepository.removeWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));

    final result = await usecase.execute(testTVDetail);

    verify(mockTVRepository.removeWatchlist(testTVDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
