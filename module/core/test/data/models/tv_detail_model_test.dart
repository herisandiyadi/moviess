import 'package:core/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvDetailModel = TvDetailModel(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: const [1, 2],
    firstAirDate: DateTime.now(),
    genres: const [],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    languages: const ['us'],
    lastAirDate: DateTime.now(),
    name: 'name',
    nextEpisodeToAir: 'nextEpisodeToAir',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: const ['us'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    productionCountries: const [],
    seasons: const [],
    spokenLanguages: const [],
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
