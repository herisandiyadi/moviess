import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_detail.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTvDetail(mockTVRepository);
  });

  const tId = 2;

  test('should get tv show detail from repository', () async {
    when(mockTVRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(tTvDetail));

    final result = await usecase.execute(tId);

    expect(result, Right(tTvDetail));
  });
}
