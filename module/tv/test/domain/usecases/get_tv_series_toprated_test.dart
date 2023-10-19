import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_toprated.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvTopRated usecase;
  late MockTVRepository mockTVRepository;

  setUp(() async {
    mockTVRepository = MockTVRepository();
    usecase = GetTvTopRated(mockTVRepository);
  });

  final testTvShow = <Tv>[];

  test('should get TV Series : Top Rated', () async {
    when(mockTVRepository.getTvTopRated())
        .thenAnswer((_) async => Right(testTvShow));
    final result = await usecase.execute();
    expect(result, Right(testTvShow));
  });
}
