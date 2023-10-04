import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tv_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchlistTv(mockTVRepository);
  });

  test('should get list of Tv Series from the repository', () async {
    when(mockTVRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvList));

    final result = await usecase.execute();

    expect(result, Right(testTvList));
  });
}
