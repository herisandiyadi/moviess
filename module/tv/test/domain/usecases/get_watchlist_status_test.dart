import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tvseries/get_watchlist_tv_status.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetWatchListTVStatus usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchListTVStatus(mockTVRepository);
  });

  test('should get watchlist tv status from repository', () async {
    when(mockTVRepository.isAddedtoWatchList(1)).thenAnswer((_) async => true);

    final result = await usecase.execute(1);

    expect(result, true);
  });
}
