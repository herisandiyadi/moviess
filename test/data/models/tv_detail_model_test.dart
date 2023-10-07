import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvDetailModel = TvDetailModel(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2],
    firstAirDate: DateTime.now(),
    genres: [],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    languages: ['us'],
    lastAirDate: DateTime.now(),
    name: 'name',
    nextEpisodeToAir: 'nextEpisodeToAir',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['us'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    productionCountries: [],
    seasons: [],
    spokenLanguages: [],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  test('Test TVDetail Model', () {
    final jsonResult = tvDetailModel.toJson();

    expect(jsonResult['id'], 1);
    expect(jsonResult['homepage'], 'homepage');
    expect(jsonResult['production_companies'], []);
  });
}
