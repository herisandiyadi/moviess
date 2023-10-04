import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShow usecase;
  late MockTVRepository mockTVRepository;

  setUp(() async {
    mockTVRepository = MockTVRepository();
    usecase = SearchTvShow(mockTVRepository);
  });

  final tQuery = 'tagesschau';
  final testTvShow = <Tv>[];

  test('should Search TV Series', () async {
    when(mockTVRepository.searchTvShow(tQuery))
        .thenAnswer((_) async => Right(testTvShow));
    final result = await usecase.execute(tQuery);
    expect(result, Right(testTvShow));
  });
}
