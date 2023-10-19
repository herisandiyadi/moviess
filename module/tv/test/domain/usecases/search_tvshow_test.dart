import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/search_tvshow.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SearchTvShow usecase;
  late MockTVRepository mockTVRepository;

  setUp(() async {
    mockTVRepository = MockTVRepository();
    usecase = SearchTvShow(mockTVRepository);
  });

  const tQuery = 'tagesschau';
  final testTvShow = <Tv>[];

  test('should Search TV Series', () async {
    when(mockTVRepository.searchTvShow(tQuery))
        .thenAnswer((_) async => Right(testTvShow));
    final result = await usecase.execute(tQuery);
    expect(result, Right(testTvShow));
  });
}
