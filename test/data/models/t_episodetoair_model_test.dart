import 'package:ditonton/data/models/t_episodetoair_model.dart';
import 'package:ditonton/domain/entities/tv_episode_toair.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvEpisode = TEpisodeToAirModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    airDate: DateTime.now(),
    episodeNumber: 1,
    episodeType: 'episodeType',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
  );

  test('Test TV Episode to air Model', () {
    final jsonResult = tvEpisode.toJson();

    expect(jsonResult['id'], 1);
    expect(jsonResult['name'], 'name');
  });
}
