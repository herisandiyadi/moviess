import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_ontheair.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvSeriesOnTheAir usecase;
  late MockTVRepository mockTVRepository;

  setUp(() async {
    mockTVRepository = MockTVRepository();
    usecase = GetTvSeriesOnTheAir(mockTVRepository);
  });

  final testTvShow = <Tv>[];

  test('should get TV Series : On The Air', () async {
    when(mockTVRepository.getTvSeriesOnTheAir())
        .thenAnswer((_) async => Right(testTvShow));
    final result = await usecase.execute();
    expect(result, Right(testTvShow));
  });
}
