import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_production_country.dart';

void main() {
  test('Equatable props should be correct', () {
    const tvProduction = TvProductionCountry(
      iso31661: 'iso31661',
      name: 'name',
    );

    final props = tvProduction.props;

    expect(props, [
      'iso31661',
      'name',
    ]);
  });
}
