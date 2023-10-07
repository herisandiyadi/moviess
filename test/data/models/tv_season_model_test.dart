import 'package:ditonton/data/models/tv_season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final seasonModel = TVSeasonModel(
    airDate: DateTime.now(),
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1,
  );

  test('Test model to Json', () {
    final jsonResult = seasonModel.toJson();
    expect(jsonResult['id'], 1);
    expect(jsonResult['name'], 'name');
  });
}
