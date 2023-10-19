import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const genreModel = GenreModel(id: 1, name: 'name');
  test('Genre Model Test', () {
    final jsonResult = genreModel.toJson();

    expect(jsonResult['id'], 1);
    expect(jsonResult['name'], 'name');
  });
}
