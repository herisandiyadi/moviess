import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_recomendations.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvRecomendations usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTvRecomendations(mockTVRepository);
  });

  const tId = 2;
  final tTvShow = <Tv>[];

  test('should get tv show detail from repository', () async {
    when(mockTVRepository.getTvRecomendations(tId))
        .thenAnswer((_) async => Right(tTvShow));

    final result = await usecase.execute(tId);

    expect(result, Right(tTvShow));
  });
}
