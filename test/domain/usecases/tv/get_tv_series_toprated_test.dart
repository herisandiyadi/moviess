import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_toprated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

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
