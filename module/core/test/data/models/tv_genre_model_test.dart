import 'package:core/data/models/tv_genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tvGenreModel = TVGenreModel(id: 1, name: 'name');

  test('Test TV genre model', () {
    final jsonResult = tvGenreModel.toJson();

    expect(jsonResult['id'], 1);
    expect(jsonResult['name'], 'name');
  });
}
