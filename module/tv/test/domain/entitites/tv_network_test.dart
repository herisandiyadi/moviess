import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_network.dart';

void main() {
  test('Equatable props should be correct', () {
    const tvNetwork = TvNetwork(
      id: 1,
      logoPath: 'logoPath',
      name: 'name',
      originCountry: 'originCountry',
    );

    final props = tvNetwork.props;

    expect(props, [
      1,
      'logoPath',
      'name',
      'originCountry',
    ]);
  });
}
