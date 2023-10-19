import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('Check Network : ', () {
    test('When device is online', () async {
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      final result = await networkInfo.isConnected;
      expect(result, true);
    });

    test('When device is offline', () async {
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);
      final result = await networkInfo.isConnected;
      expect(result, false);
    });
  });
}
