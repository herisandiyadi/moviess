import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_populer.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTVSeriesPopuler usecase;
  late MockTVRepository mockTVRepository;

  setUp(() async {
    mockTVRepository = MockTVRepository();
    usecase = GetTVSeriesPopuler(mockTVRepository);
  });

  final testTvShow = <Tv>[];

  test('should get TV Series : Popular', () async {
    when(mockTVRepository.getTvSeriesPopuler())
        .thenAnswer((_) async => Right(testTvShow));
    final result = await usecase.execute();
    expect(result, Right(testTvShow));
  });
}
