import 'package:ditonton/data/models/tv_product_country_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvProductCountry = TvProductionCountryModel(
    iso31661: 'iso31661',
    name: 'name',
  );

  test('Test Model to Json', () {
    final jsonResult = tvProductCountry.toJson();
    expect(jsonResult['name'], 'name');
  });
}
