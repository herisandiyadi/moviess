import 'package:ditonton/data/models/tv_spoken_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testModel = SpokenLanguageModel(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: 'name',
  );

  test('Test model to Json', () {
    final jsonResult = testModel.toJson();

    expect(jsonResult['name'], 'name');
    expect(jsonResult['english_name'], 'englishName');
  });
}
